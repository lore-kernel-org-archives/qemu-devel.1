Received: from eggs.gnu.org ([2001:4830:134:3::10]:53028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPWhx-0007yM-C6
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPWhs-0006sX-8P
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:54:37 -0500
References: <1542276385-7638-1-git-send-email-liq3ea@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <865c7495-e007-6d0e-74fc-a35d9a1cbcfa@redhat.com>
Date: Wed, 21 Nov 2018 18:54:26 +0100
MIME-Version: 1.0
In-Reply-To: <1542276385-7638-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl.c: remove outdated comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, laurent@vivier.eu
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 15/11/18 11:06, Li Qiang wrote:
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  vl.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index fa25d1ae2d..ae63018a1d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1522,9 +1522,6 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
>      return 1;
>  }
>  
> -/***********************************************************/
> -/* main execution loop */
> -
>  struct vm_change_state_entry {
>      VMChangeStateHandler *cb;
>      void *opaque;
> 

Queued, thanks.

Paolo

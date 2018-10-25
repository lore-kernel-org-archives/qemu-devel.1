Received: from eggs.gnu.org ([2001:4830:134:3::10]:37382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFg4R-0002m3-F8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFg4L-00043R-KQ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:53:07 -0400
References: <1539261534-2795-1-git-send-email-liq3ea@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9d750f50-3692-8376-6b04-34b1c3991b15@vivier.eu>
Date: Thu, 25 Oct 2018 14:52:52 +0100
MIME-Version: 1.0
In-Reply-To: <1539261534-2795-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] piix: use TYPE_FOO
 constants than string constats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 11/10/2018 13:38, Li Qiang wrote:
> Make them more QOMConventional.
> Cc:qemu-trivial@nongnu.org 
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/pci-host/piix.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Applied,

Thanks,
Laurent

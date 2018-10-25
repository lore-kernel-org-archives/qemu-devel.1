Received: from eggs.gnu.org ([2001:4830:134:3::10]:40776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFgC3-0002U2-Is
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFgC2-0002KB-Ky
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:00:59 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-11-crosa@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a49bbe8f-7c63-a7c7-64e1-01f9842a76ef@vivier.eu>
Date: Thu, 25 Oct 2018 15:00:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-11-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 10/10] scripts/qemu.py:
 remove trailing quotes on docstring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Max Reitz <mreitz@redhat.com>

On 04/10/2018 17:18, Cleber Rosa wrote:
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qemu.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 7abe26de69..676eb9709a 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -88,7 +88,7 @@ class QEMUMachine(object):
>          @param name: prefix for socket and log file names (default: qemu-PID)
>          @param test_dir: where to create socket and log file
>          @param monitor_address: address for QMP monitor
> -        @param socket_scm_helper: helper program, required for send_fd_scm()"
> +        @param socket_scm_helper: helper program, required for send_fd_scm()
>          @note: Qemu process is not started until launch() is used.
>          '''
>          if args is None:
> 

Applied

Thanks,
Laurent

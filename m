Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QLz-0007Uk-Sj
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QLt-0008Up-64
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:41:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8QLs-0008SM-Pt
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:41:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so1983162wmq.4
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:41:05 -0700 (PDT)
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-11-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ddd4724b-5987-b80a-7bd4-18fceb6b1fd5@redhat.com>
Date: Fri, 5 Oct 2018 15:41:03 +0200
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-11-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/10] scripts/qemu.py: remove trailing
 quotes on docstring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 04/10/2018 18:18, Cleber Rosa wrote:
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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

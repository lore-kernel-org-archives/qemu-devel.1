Received: from eggs.gnu.org ([209.51.188.92]:49265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDo6w-0001pE-Jl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDo6v-0000uh-JN
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:36:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDo6v-0000uG-9c
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:36:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so20195699wre.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 03:36:13 -0700 (PDT)
References: <20190409053320.14612-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dcf3ed0d-f850-69bf-fc52-827b1e2a1a9e@redhat.com>
Date: Tue, 9 Apr 2019 12:36:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190409053320.14612-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Update configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 4/9/19 7:33 AM, Stefan Weil wrote:
> The last *.aml file was removed in commit 13b1881aacc7e5018773bd545bbaf8d5476699ee.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 1c563a7027..9c5d9a8c96 100755
> --- a/configure
> +++ b/configure
> @@ -7886,7 +7886,6 @@ LINKS="$LINKS python"
>  for bios_file in \
>      $source_path/pc-bios/*.bin \
>      $source_path/pc-bios/*.lid \
> -    $source_path/pc-bios/*.aml \
>      $source_path/pc-bios/*.rom \
>      $source_path/pc-bios/*.dtb \
>      $source_path/pc-bios/*.img \
> 

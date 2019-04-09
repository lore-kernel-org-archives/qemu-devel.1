Received: from eggs.gnu.org ([209.51.188.92]:60464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDnIc-00059q-CX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDnIb-0001gg-DB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:44:14 -0400
Date: Tue, 9 Apr 2019 11:44:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190409114400.12258e41@redhat.com>
In-Reply-To: <20190409053320.14612-1-sw@weilnetz.de>
References: <20190409053320.14612-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Update configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Tue,  9 Apr 2019 07:33:20 +0200
Stefan Weil <sw@weilnetz.de> wrote:

> The last *.aml file was removed in commit 13b1881aacc7e5018773bd545bbaf8d5476699ee.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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

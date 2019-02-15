Received: from eggs.gnu.org ([209.51.188.92]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gucf4-0001lt-MK
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gucew-0007Dt-Jc
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:32:06 -0500
References: <20181218115615.1499-1-philmd@redhat.com>
	<20181218115615.1499-6-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cfde5bf6-3ab6-4b04-0fb1-382237700f5e@redhat.com>
Date: Fri, 15 Feb 2019 13:31:41 +0100
MIME-Version: 1.0
In-Reply-To: <20181218115615.1499-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/12] MAINTAINERS: Add missing entries
 for the QObject section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 18/12/2018 12.56, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Removed qdist
> ---
>  MAINTAINERS | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a94b0dab3..a381882c27 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1900,10 +1900,14 @@ F: include/qapi/qmp/
>  X: include/qapi/qmp/dispatch.h
>  F: scripts/coccinelle/qobject.cocci
>  F: tests/check-qdict.c
> -F: tests/check-qnum.c
>  F: tests/check-qjson.c
>  F: tests/check-qlist.c
> +F: tests/check-qlit.c
> +F: tests/check-qnull.c
> +F: tests/check-qnum.c
> +F: tests/check-qobject.c
>  F: tests/check-qstring.c
> +F: qdict-test-data.txt
>  T: git https://repo.or.cz/qemu/armbru.git qapi-next

Reviewed-by: Thomas Huth <thuth@redhat.com>

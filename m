Received: from eggs.gnu.org ([209.51.188.92]:50825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0kZW-0008R2-Hi
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0kZV-0002LC-Mq
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:11:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190213130240.15492-1-armbru@redhat.com>
Date: Mon, 04 Mar 2019 11:11:42 +0100
In-Reply-To: <20190213130240.15492-1-armbru@redhat.com> (Markus Armbruster's
	message of "Wed, 13 Feb 2019 14:02:40 +0100")
Message-ID: <87o96r3q5d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] build: Correct explanation of unnest-vars
 example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>

I guess this could go via -trivial.

Markus Armbruster <armbru@redhat.com> writes:

> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  rules.mak | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rules.mak b/rules.mak
> index 86e033d815..19f3d2c126 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -327,7 +327,7 @@ endef
>  #     ../water/ice.mo-libs = -licemaker
>  #     ../water/ice.mo-objs = ../water/ice1.o ../water/ice2.o
>  #
> -# Note that 'hot' didn't include 'season/' in the input, so 'summer.o' is not
> +# Note that 'hot' didn't include 'water/' in the input, so 'steam.o' is not
>  # included.
>  #
>  define unnest-vars

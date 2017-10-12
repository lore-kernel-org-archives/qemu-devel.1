Received: from eggs.gnu.org ([2001:4830:134:3::10]:51775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e2Zlf-0000o8-AS
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e2Zle-0004eG-L1
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:27:03 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e2Zle-0004be-G1
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:27:02 -0400
Received: by mail-oi0-x241.google.com with SMTP id h200so2187987oib.1
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 02:27:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171012064448.20276-1-chen_han_xiao@126.com>
References: <20171012064448.20276-1-chen_han_xiao@126.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 12 Oct 2017 11:26:59 +0200
Message-ID: <CAJ+F1C+sj6o-XrYvT_MjEy3_tpM7zhZYm4cjBfUY0r1uPK2R9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi-docs: fix a comment typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>

On Thu, Oct 12, 2017 at 8:44 AM, Chen Hanxiao <chen_han_xiao@126.com> wrote=
:
> From: Chen Hanxiao <chenhanxiao@gmail.com>
>
>   s/Subection/Subsection
>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  docs/devel/qapi-code-gen.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index f04c63fe82..06ab699066 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -63,7 +63,7 @@ Comment text starting with '=3D' is a section title:
>
>  Double the '=3D' for a subsection title:
>
> -    # =3D=3D Subection title
> +    # =3D=3D Subsection title
>
>  '|' denotes examples:
>
> --
> 2.13.5
>
>



--=20
Marc-Andr=C3=A9 Lureau

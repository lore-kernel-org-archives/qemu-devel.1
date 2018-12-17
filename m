Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYqbG-0002Y7-UC
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYqaa-0000SF-15
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:57:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gYqaZ-0000Pg-OD
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:57:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 675E9C00C10B
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 10:57:29 +0000 (UTC)
References: <20181207165414.17566-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <294b4695-8eeb-da79-f40c-74b57f6ca629@redhat.com>
Date: Mon, 17 Dec 2018 11:57:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181207165414.17566-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Add license files for GPLv2+
 and CC-BY-SA-4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On 2018-12-07 17:54, Daniel P. Berrang=C3=A9 wrote:
> The intent is that from this point onwards, content for this repository
> is dual-licensed under the GPLv2+ and CC-BY-SA-4.0

Thanks for taking care of this!

Some remarks / questions below...

[...]
> ---
>  LICENSE-CC-BY-3.0.md     | 324 +++++++++++++++++++++++++++++++++++
>  LICENSE-CC-BY-SA-4.0.md  | 356 +++++++++++++++++++++++++++++++++++++++
>  LICENSE-GPL.md           | 346 +++++++++++++++++++++++++++++++++++++
>  LICENSE.md               |  18 ++
>  _includes/copyright.html |   7 +-
>  5 files changed, 1047 insertions(+), 4 deletions(-)
>  create mode 100644 LICENSE-CC-BY-3.0.md
>  create mode 100644 LICENSE-CC-BY-SA-4.0.md
>  create mode 100644 LICENSE-GPL.md
>  create mode 100644 LICENSE.md
>=20
> diff --git a/LICENSE-CC-BY-3.0.md b/LICENSE-CC-BY-3.0.md
> new file mode 100644
> index 0000000..42693c3
> --- /dev/null
> +++ b/LICENSE-CC-BY-3.0.md
> @@ -0,0 +1,324 @@
> +---
> +permalink: /license-cc-by-3.0/
> +title: Creative Commons Attribution 3.0 Unported
> +---
> +
> +Creative Commons Legal Code
> +
> +Attribution 3.0 Unported
> +
> +    CREATIVE COMMONS CORPORATION IS NOT A LAW FIRM AND DOES NOT PROVID=
E
> +    LEGAL SERVICES. DISTRIBUTION OF THIS LICENSE DOES NOT CREATE AN
> +    ATTORNEY-CLIENT RELATIONSHIP. CREATIVE COMMONS PROVIDES THIS
> +    INFORMATION ON AN "AS-IS" BASIS. CREATIVE COMMONS MAKES NO WARRANT=
IES
> +    REGARDING THE INFORMATION PROVIDED, AND DISCLAIMS LIABILITY FOR
> +    DAMAGES RESULTING FROM ITS USE.
> +
> +License
> +
> +THE WORK (AS DEFINED BELOW) IS PROVIDED UNDER THE TERMS OF THIS CREATI=
VE
> +COMMONS PUBLIC LICENSE ("CCPL" OR "LICENSE"). THE WORK IS PROTECTED BY
> +COPYRIGHT AND/OR OTHER APPLICABLE LAW. ANY USE OF THE WORK OTHER THAN =
AS
> +AUTHORIZED UNDER THIS LICENSE OR COPYRIGHT LAW IS PROHIBITED.
> +
> +BY EXERCISING ANY RIGHTS TO THE WORK PROVIDED HERE, YOU ACCEPT AND AGR=
EE
> +TO BE BOUND BY THE TERMS OF THIS LICENSE. TO THE EXTENT THIS LICENSE M=
AY
> +BE CONSIDERED TO BE A CONTRACT, THE LICENSOR GRANTS YOU THE RIGHTS
> +CONTAINED HERE IN CONSIDERATION OF YOUR ACCEPTANCE OF SUCH TERMS AND
> +CONDITIONS.
> +
> +1. Definitions
> +
> + a. "Adaptation" means a work based upon the Work, or upon the Work an=
d
> +    other pre-existing works, such as a translation, adaptation,
> +    derivative work, arrangement of music or other alterations of a
> +    literary or artistic work, or phonogram or performance and include=
s
> +    cinematographic adaptations or any other form in which the Work ma=
y be
> +    recast, transformed, or adapted including in any form recognizably
> +    derived from the original, except that a work that constitutes a
> +    Collection will not be considered an Adaptation for the purpose of
> +    this License. For the avoidance of doubt, where the Work is a musi=
cal
> +    work, performance or phonogram, the synchronization of the Work in
> +    timed-relation with a moving image ("synching") will be considered=
 an
> +    Adaptation for the purpose of this License.
[...]

You did not use <pre>-tags for the CC-BY-3.0 license, only for the other
two. Thus the pre-formatting gets completely lost in the web browser
here, making the text quite hard to read. I'd suggest to use <pre> here,
too (I can add the tags before committing in case you don't want to respi=
n).

[...]
> diff --git a/LICENSE.md b/LICENSE.md
> new file mode 100644
> index 0000000..ba73300
> --- /dev/null
> +++ b/LICENSE.md
> @@ -0,0 +1,18 @@
> +---
> +permalink: /license
> +title: QEMU website licensing
> +---
> +
> +Except where otherwise noted, the content in this repository is provid=
ed under
> +a choice of two licenses:

I'd maybe replace "in this repository" with "on this website", since
it's not quite obvious for the normal user that the website is stored in
a git repository, too. (If you agree, I can fix this also up in case you
don't want to respin)

 Thomas

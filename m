Received: from eggs.gnu.org ([2001:4830:134:3::10]:35910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gYrqq-0007vh-Cp
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gYrqm-0000vr-FV
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:18:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gYrqm-0000ux-6H
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:18:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC4D82DE3B
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 12:18:17 +0000 (UTC)
Date: Mon, 17 Dec 2018 12:18:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181217121812.GF30264@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181207165414.17566-1-berrange@redhat.com>
	<294b4695-8eeb-da79-f40c-74b57f6ca629@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <294b4695-8eeb-da79-f40c-74b57f6ca629@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Mon, Dec 17, 2018 at 11:57:27AM +0100, Thomas Huth wrote:
> On 2018-12-07 17:54, Daniel P. Berrang=C3=A9 wrote:
> > The intent is that from this point onwards, content for this reposito=
ry
> > is dual-licensed under the GPLv2+ and CC-BY-SA-4.0
>=20
> Thanks for taking care of this!
>=20
> Some remarks / questions below...
>=20
> [...]
> > ---
> >  LICENSE-CC-BY-3.0.md     | 324 +++++++++++++++++++++++++++++++++++
> >  LICENSE-CC-BY-SA-4.0.md  | 356 +++++++++++++++++++++++++++++++++++++=
++
> >  LICENSE-GPL.md           | 346 +++++++++++++++++++++++++++++++++++++
> >  LICENSE.md               |  18 ++
> >  _includes/copyright.html |   7 +-
> >  5 files changed, 1047 insertions(+), 4 deletions(-)
> >  create mode 100644 LICENSE-CC-BY-3.0.md
> >  create mode 100644 LICENSE-CC-BY-SA-4.0.md
> >  create mode 100644 LICENSE-GPL.md
> >  create mode 100644 LICENSE.md
> >=20
> > diff --git a/LICENSE-CC-BY-3.0.md b/LICENSE-CC-BY-3.0.md
> > new file mode 100644
> > index 0000000..42693c3
> > --- /dev/null
> > +++ b/LICENSE-CC-BY-3.0.md
> > @@ -0,0 +1,324 @@
> > +---
> > +permalink: /license-cc-by-3.0/
> > +title: Creative Commons Attribution 3.0 Unported
> > +---
> > +
> > +Creative Commons Legal Code
> > +
> > +Attribution 3.0 Unported
> > +
> > +    CREATIVE COMMONS CORPORATION IS NOT A LAW FIRM AND DOES NOT PROV=
IDE
> > +    LEGAL SERVICES. DISTRIBUTION OF THIS LICENSE DOES NOT CREATE AN
> > +    ATTORNEY-CLIENT RELATIONSHIP. CREATIVE COMMONS PROVIDES THIS
> > +    INFORMATION ON AN "AS-IS" BASIS. CREATIVE COMMONS MAKES NO WARRA=
NTIES
> > +    REGARDING THE INFORMATION PROVIDED, AND DISCLAIMS LIABILITY FOR
> > +    DAMAGES RESULTING FROM ITS USE.
> > +
> > +License
> > +
> > +THE WORK (AS DEFINED BELOW) IS PROVIDED UNDER THE TERMS OF THIS CREA=
TIVE
> > +COMMONS PUBLIC LICENSE ("CCPL" OR "LICENSE"). THE WORK IS PROTECTED =
BY
> > +COPYRIGHT AND/OR OTHER APPLICABLE LAW. ANY USE OF THE WORK OTHER THA=
N AS
> > +AUTHORIZED UNDER THIS LICENSE OR COPYRIGHT LAW IS PROHIBITED.
> > +
> > +BY EXERCISING ANY RIGHTS TO THE WORK PROVIDED HERE, YOU ACCEPT AND A=
GREE
> > +TO BE BOUND BY THE TERMS OF THIS LICENSE. TO THE EXTENT THIS LICENSE=
 MAY
> > +BE CONSIDERED TO BE A CONTRACT, THE LICENSOR GRANTS YOU THE RIGHTS
> > +CONTAINED HERE IN CONSIDERATION OF YOUR ACCEPTANCE OF SUCH TERMS AND
> > +CONDITIONS.
> > +
> > +1. Definitions
> > +
> > + a. "Adaptation" means a work based upon the Work, or upon the Work =
and
> > +    other pre-existing works, such as a translation, adaptation,
> > +    derivative work, arrangement of music or other alterations of a
> > +    literary or artistic work, or phonogram or performance and inclu=
des
> > +    cinematographic adaptations or any other form in which the Work =
may be
> > +    recast, transformed, or adapted including in any form recognizab=
ly
> > +    derived from the original, except that a work that constitutes a
> > +    Collection will not be considered an Adaptation for the purpose =
of
> > +    this License. For the avoidance of doubt, where the Work is a mu=
sical
> > +    work, performance or phonogram, the synchronization of the Work =
in
> > +    timed-relation with a moving image ("synching") will be consider=
ed an
> > +    Adaptation for the purpose of this License.
> [...]
>=20
> You did not use <pre>-tags for the CC-BY-3.0 license, only for the othe=
r
> two. Thus the pre-formatting gets completely lost in the web browser
> here, making the text quite hard to read. I'd suggest to use <pre> here=
,
> too (I can add the tags before committing in case you don't want to res=
pin).

Yes, my bad. Please do add the <pre> yourself.

> [...]
> > diff --git a/LICENSE.md b/LICENSE.md
> > new file mode 100644
> > index 0000000..ba73300
> > --- /dev/null
> > +++ b/LICENSE.md
> > @@ -0,0 +1,18 @@
> > +---
> > +permalink: /license
> > +title: QEMU website licensing
> > +---
> > +
> > +Except where otherwise noted, the content in this repository is prov=
ided under
> > +a choice of two licenses:
>=20
> I'd maybe replace "in this repository" with "on this website", since
> it's not quite obvious for the normal user that the website is stored i=
n
> a git repository, too. (If you agree, I can fix this also up in case yo=
u
> don't want to respin)

Yes, it is fine if you change that when pushing.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehg6T-0000bq-4X
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehg5X-0001Do-Qh
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:30:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ehg5X-0001Cq-Gk
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:29:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97A944F1B0
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 18:29:26 +0000 (UTC)
Date: Fri, 2 Feb 2018 18:29:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180202182922.GQ15403@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180202071751.16316-1-kraxel@redhat.com>
	<a9e4deb4-5162-19a1-324e-640abd272fc3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9e4deb4-5162-19a1-324e-640abd272fc3@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Ui 20180202 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Fri, Feb 02, 2018 at 11:49:55AM -0600, Eric Blake wrote:
> On 02/02/2018 01:17 AM, Gerd Hoffmann wrote:
> > The following changes since commit 11ed801d3df3c6e46b2f1f97dcfbf4ca3a=
2a2f4f:
> >=20
> >   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-re=
quest' into staging (2018-01-30 09:47:51 +0000)
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.kraxel.org/qemu tags/ui-20180202-pull-request
> >=20
> > for you to fetch changes up to 627ebec208a8809818589e17f4fce55a59420a=
d2:
> >=20
> >   ui: correctly advance output buffer when writing SASL data (2018-02=
-02 07:48:18 +0100)
> >=20
> > ----------------------------------------------------------------
> > ui: use QIONetListener in vnc, bugfixes for sdl1 and vnc.
> >=20
> > ----------------------------------------------------------------
> >=20
> > Daniel P. Berrange (1):
> >   ui: convert VNC server to QIONetListener
> >=20
> > Daniel P. Berrang=C3=A9 (2):
>=20
> Odd effects based on choice of UTF-8 spellings.  Dan, do you want to ad=
d
> a .mailmap entry to consolidate on a single preferred form of your name=
?

Oh yes, I've just sent such a patch.  I switched to the proper unicode
spelling of my name in git since I figure enough of the software world
handles unicode correctly by now :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

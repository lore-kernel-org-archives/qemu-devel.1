Received: from eggs.gnu.org ([209.51.188.92]:55740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h3LoD-0000vU-Bi
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h3LbI-0007TS-O8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:08:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:35736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h3LbI-0007SI-Ff
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:08:20 -0400
Date: Mon, 11 Mar 2019 15:08:16 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190311140816.gxveswhhzofwlgut@function>
References: <20190311082619.17966-1-kraxel@redhat.com>
	<CAFEAcA_PbFmhoDPK3PdbQJQj+a0UqO6JqFZb5BofJjcH=6d7xQ@mail.gmail.com>
	<20190311135116.GX12393@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311135116.GX12393@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt]  [PULL 0/5] Ui 20190311 v2 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Daniel P. Berrang=C3=A9, le lun. 11 mars 2019 13:51:16 +0000, a ecrit:
> On Mon, Mar 11, 2019 at 01:45:13PM +0000, Peter Maydell wrote:
> > On Mon, 11 Mar 2019 at 08:40, Gerd Hoffmann <kraxel@redhat.com> wrote=
:
> > >
> > > The following changes since commit e2a18635a400b0e68679614132e9ef63=
16105590:
> > >
> > >   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-03=
-08' into staging (2019-03-09 20:55:44 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kraxel.org/qemu tags/ui-20190311-v2-pull-request
> > >
> > > for you to fetch changes up to 0143840771548e8ffece831398d745880ddf=
a080:
> > >
> > >   monitor: deprecate acl_show, acl_reset, acl_policy, acl_add, acl_=
remove (2019-03-11 08:39:02 +0100)
> > >
> > > ----------------------------------------------------------------
> > > curses: wide char input support.
> > > vnc: acl update, stall fix.
> > >
> > > ----------------------------------------------------------------
> >=20
> > Applied, thanks.
> >=20
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> > for any user-visible changes.
>=20
> Gerd, I'll take care of updating the changelog for the auth / acl
> related parts of the pull request

I wanted to do the same for the curses part but I don't seem to have a
wiki account, could somebody create one for me?

Samuel

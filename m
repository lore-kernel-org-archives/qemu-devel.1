Received: from eggs.gnu.org ([2001:4830:134:3::10]:58407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyg4s-0000PO-GB
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyg4r-0001wh-Dg
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:55:02 -0400
Date: Wed, 21 Mar 2018 15:54:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180321155424.GV8551@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1521642402-197739-1-git-send-email-mst@redhat.com>
	<20180321151922.GR8551@redhat.com>
	<20180321173309-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321173309-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu: replace "" with <> in headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Wed, Mar 21, 2018 at 05:39:48PM +0200, Michael S. Tsirkin wrote:
> On Wed, Mar 21, 2018 at 03:19:22PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Mar 21, 2018 at 04:46:32PM +0200, Michael S. Tsirkin wrote:
> > > Our current scheme is to use
> > >  #include ""
> > > for internal headers, and
> > >  #include <>
> > > for external ones.
> > >=20
> > > Unfortunately this is not based on compiler support: from C point o=
f
> > > view, the "" form merely looks up headers in the current directory
> > > and then falls back on <> directories.
> > >=20
> > > Thus, for example, a system header trace.h - should it be present -=
 will
> > > conflict with our local trace.h
> >=20
> > If our local "trace.h" is in the current directory, then using ""
> > is right and you can still use <trace.h> to get the system version.
> >=20
> > If our local trace.h is in include/ top level, then it is going to
> > block use of the system trace.h regardless of whether we use <> or ""
> >=20
> > Fortunately our include/ tree uses sub-dirs, so we would typically
> > use  #include "$subdir/trace.h" and  #include <trace.h> would still
> > find the system header.
> > We just have to be careful we don't add stuff at the top level of
> > our include/ dir with names that are liable to clash. This might
> > suggest renaming  include/elf.h to include/qemu/elf.h, or just
> > moving elf.h to the qemu/ subdirectory. Likewise include/glib-compat.=
h
> > might be better moved to qemu/ subdirectory.
> >=20
>=20
> This is exactly what this patch proposes, with a uniform scheme:
> start everything with qemu/.
>=20
> >=20
> > > As another example of problems, a header by the same name in the so=
urce
> > > directory will always be picked up first - before any headers in
> > > the include directory.
> >=20
> > There's only a couple of headers in the top level of our include/
> > directory - everything else is pulled in with a named path
> > eg #include "block/block_int.h", so that would not conflict with
> > reference to a bare #include "block_int.h" from the current directory=
.
>=20
> We can not know that there are no system headers that start with block/=
 on
> any current or future systems.

Ah true, good point.  I guess that's where the benefit of -iquote
comes into play.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

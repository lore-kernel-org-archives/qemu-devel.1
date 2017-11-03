Received: from eggs.gnu.org ([2001:4830:134:3::10]:55489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAdIy-0001Cf-Gh
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAdIv-0004h9-3d
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:50:44 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:49855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eAdIu-0004fp-NZ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:50:41 -0400
Received: by mail-wr0-x231.google.com with SMTP id g90so2733818wrd.6
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 07:50:40 -0700 (PDT)
Date: Fri, 3 Nov 2017 14:50:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103145037.GQ5078@stefanha-x1.localdomain>
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-3-git-send-email-changpeng.liu@intel.com>
	<20171019151745.GH6205@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B5D8682@SHSMSX103.ccr.corp.intel.com>
	<20171020095435.GD21393@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B5D8EB6@SHSMSX103.ccr.corp.intel.com>
	<20171023171146.GB15029@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B5D9206@SHSMSX103.ccr.corp.intel.com>
	<20171024125323.GH18756@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B5D97A2@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8HhMLSHvAouSipEr"
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B5D97A2@SHSMSX103.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/4] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>


--8HhMLSHvAouSipEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2017 at 01:34:39AM +0000, Liu, Changpeng wrote:
>=20
>=20
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> > Sent: Tuesday, October 24, 2017 8:53 PM
> > To: Liu, Changpeng <changpeng.liu@intel.com>
> > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; mst@redhat.com;
> > marcandre.lureau@redhat.com; felipe@nutanix.com; Harris, James R
> > <james.r.harris@intel.com>
> > Subject: Re: [PATCH v4 2/4] vhost-user-blk: introduce a new vhost-user-=
blk host
> > device
> >=20
> > On Tue, Oct 24, 2017 at 12:44:30AM +0000, Liu, Changpeng wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> > > > Sent: Tuesday, October 24, 2017 1:12 AM
> > > > To: Liu, Changpeng <changpeng.liu@intel.com>
> > > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; mst@redhat.com;
> > > > marcandre.lureau@redhat.com; felipe@nutanix.com; Harris, James R
> > > > <james.r.harris@intel.com>
> > > > Subject: Re: [PATCH v4 2/4] vhost-user-blk: introduce a new vhost-u=
ser-blk
> > host
> > > > device
> > > >
> > > > On Mon, Oct 23, 2017 at 04:26:36AM +0000, Liu, Changpeng wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> > > > > > Sent: Friday, October 20, 2017 5:55 PM
> > > > > > To: Liu, Changpeng <changpeng.liu@intel.com>
> > > > > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; mst@redhat.com;
> > > > > > marcandre.lureau@redhat.com; felipe@nutanix.com; Harris, James R
> > > > > > <james.r.harris@intel.com>
> > > > > > Subject: Re: [PATCH v4 2/4] vhost-user-blk: introduce a new vho=
st-user-blk
> > > > host
> > > > > > device
> > > > > >
> > > > > > On Fri, Oct 20, 2017 at 01:47:58AM +0000, Liu, Changpeng wrote:
> > > > > > > > > +static Property vhost_user_blk_properties[] =3D {
> > > > > > > > > +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> > > > > > > > > +    DEFINE_PROP_UINT16("num_queues", VHostUserBlk,
> > num_queues,
> > > > 1),
> > > > > > > > > +    DEFINE_PROP_UINT32("queue_size", VHostUserBlk, queue=
_size,
> > 128),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_size_max", VHostUserBlk, host_f=
eatures,
> > > > > > > > > +                      VIRTIO_BLK_F_SIZE_MAX, true),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_sizemax", VHostUserBlk, host_fe=
atures,
> > > > > > > > > +                      VIRTIO_BLK_F_SIZE_MAX, true),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_segmax", VHostUserBlk, host_fea=
tures,
> > > > > > > > > +                      VIRTIO_BLK_F_SEG_MAX, true),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_geometry", VHostUserBlk, host_f=
eatures,
> > > > > > > > > +                      VIRTIO_BLK_F_GEOMETRY, true),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_readonly", VHostUserBlk, host_f=
eatures,
> > > > > > > > > +                      VIRTIO_BLK_F_RO, false),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_blocksize", VHostUserBlk, host_=
features,
> > > > > > > > > +                      VIRTIO_BLK_F_BLK_SIZE, true),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_topology", VHostUserBlk, host_f=
eatures,
> > > > > > > > > +                      VIRTIO_BLK_F_TOPOLOGY, true),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_multiqueue", VHostUserBlk,
> > host_features,
> > > > > > > > > +                      VIRTIO_BLK_F_MQ, true),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_flush", VHostUserBlk, host_feat=
ures,
> > > > > > > > > +                      VIRTIO_BLK_F_FLUSH, true),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_barrier", VHostUserBlk, host_fe=
atures,
> > > > > > > > > +                      VIRTIO_BLK_F_BARRIER, false),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_scsi", VHostUserBlk, host_featu=
res,
> > > > > > > > > +                      VIRTIO_BLK_F_SCSI, false),
> > > > > > > > > +    DEFINE_PROP_BIT64("f_wce", VHostUserBlk, host_featur=
es,
> > > > > > > > > +                      VIRTIO_BLK_F_WCE, false),
> > > > > > > >
> > > > > > > > Please explain how feature negotation works.  The vhost-use=
r slave
> > > > > > > > advertises support features in the return value from
> > > > > > > > VHOST_USER_GET_FEATURES.  How does this additional feature =
mask
> > > > work
> > > > > > and
> > > > > > > > why is it useful?
> > > > > > > According to Paolo's previous comments, VIRTIO_BLK_F_WCE/
> > > > > > VIRTIO_BLK_F_SCSI/ VIRTIO_BLK_F_BARRIER
> > > > > > > should be removed. Here I added all the feature flags just wa=
nt to avoid
> > > > the
> > > > > > case that vhost-user slave target
> > > > > > > can support but Qemu vhost block driver cannot support it.
> > > > > >
> > > > > > Please explain a bit more how these options can be used.
> > > > > >
> > > > > > When I looked at the vhost code it seemed like the vhost slave =
can
> > > > > > report any feature bits it wishes (even things QEMU doesn't kno=
w about).
> > > > > > What is the purpose of override some of the feature bits on the=
 QEMU
> > > > > > command-line?
> > > > > Hi Stefan,
> > > > > Here I added a switch which can override vhost-slave's feature bi=
ts, for
> > > > example, vhost-slave reported `VIRTIO_BLK_F_RO`,
> > > > > but Qemu vhost-master can disable it through command line when st=
arted
> > the
> > > > Qemu. Users don't need to change any
> > > > > vhost-slave's code to disable this feature, and this is also alig=
ned with
> > vhost-
> > > > scsi and vhost-net's implementation.
> > > >
> > > > You said vhost-master can disable features but the code doesn't see=
m to
> > > > work that way:
> > > >
> > > > +    /* Turn on pre-defined features */
> > > > +    features |=3D s->host_features;
> > > User can append parameter when started Qemu: e.g: f_readonly=3Dfalse =
to
> > disable it.
> >=20
> > No, f_readonly=3Dfalse has no effect if the vhost slave replies with f_=
readonly
> > to the VHOST_USER_GET_FEATURES message.
> >=20
> > Take a look at the hw/virtio/vhost.c code:
> >=20
> >   uint64_t vhost_get_features(struct vhost_dev *hdev, const int *featur=
e_bits,
> >                               uint64_t features)
> >   {
> >       const int *bit =3D feature_bits;
> >       while (*bit !=3D VHOST_INVALID_FEATURE_BIT) {
> >           uint64_t bit_mask =3D (1ULL << *bit);
> >           if (!(hdev->features & bit_mask)) {
> >               features &=3D ~bit_mask;
> >           }
> >           bit++;
> >       }
> >       return features;
> >   }
> >=20
> > If f_readonly=3Dfalse then features |=3D s->host_features will not cont=
ain
> > f_readonly but it doesn't matter because if hdev->features (this value
> > comes from the vhost slave) has f_readonly we will not clear the bit!
> >=20
> > So again, what is the purpose of the f_* properties?  I don't understand
> > the semantics, it seems useless.
> Hi Stefan,
> I hate this piece of code too, :). There are several feature definitions =
in VirtIODevice and vhost_dev,
> I printed the features in the function: vhost_user_blk_get_features, my t=
est vhost-slave also provides RO feature, and
> I started Qemu with f_readonly=3Dfalse:
>=20
> static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
>                                             uint64_t features,
>                                             Error **errp)
> {
>     VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>     uint64_t get_features;
>=20
>     /* Turn on pre-defined host features */
>     fprintf(stdout, "Features %"PRIx64"\n", features);
>     features |=3D s->host_features;
>     fprintf(stdout, "Turn On Predefined Features %"PRIx64"\n", features);
>     fprintf(stdout, "VHOST Features %"PRIx64"\n", s->dev.features);
>=20
>     get_features =3D vhost_get_features(&s->dev, user_feature_bits, featu=
res);
>     fprintf(stdout, "Get Features %"PRIx64"\n", get_features);
>=20
>     return get_features;
> }
>=20
> Here is the result, RO feature is bit5:
> Features 179000000, This is VirtIODevice->host_features.
> Turn On Predefined Features 179001ed7, RO bit is masked here.
> VHOST Features 141001466, vhost_dev-> features, you can see that RO bit i=
s set here.
> Get Features 149001446, this is the final result, RO bit is masked finall=
y.
>=20
> Similar with vhost-scsi and vhost-net, I think this part of logic is corr=
ect.

I see.  I incorrectly thought vhost_dev->features is ORed at some stage.

This means that vhost slaves can only influence the feature bits in one
way: they can disable feature bits that QEMU knows about.  Basically the
feature bits are controlled by QEMU, not the slave.

Stefan

--8HhMLSHvAouSipEr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/II9AAoJEJykq7OBq3PIjIsH/1v9k6W+4XvcYl0FTQQpI3Zx
rZSjI4ZS6L1aTU2XU3jWKvDlLlLATIuNxLU5cbnXlaOHS0EPhcuEiZuwKb0d37j5
dQuU0z5ZVxkm55yMM8xe41VWXJM4Z/X2TEdNEFIieSUexX0sutZBE4R7gDr1K6RZ
tZ6oq9Vghcl0b0XAzBl7E1U8/u155k4kUtjHFSX+eBSswgNYghMD2k+P6IS+XQXx
PJkoQHDdsIhyQIOW97vQv4wMYBwpScOHcxx/VY2f7q8U7PvEI/1a9naRQv+voUVE
a+tLV+/ML+dfhBXXNNg4uKsEz2ktdl6YV7DXQMxTZSVRipoO7E6HVz/OYgVBTl8=
=vp9T
-----END PGP SIGNATURE-----

--8HhMLSHvAouSipEr--

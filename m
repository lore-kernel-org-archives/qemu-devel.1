Received: from eggs.gnu.org ([2001:4830:134:3::10]:57597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQYGV-0005eq-2X
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQYGT-0005gY-Ib
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:14:15 -0400
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606134327.05de9616@kitsune.suse.cz>
	<94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
	<20180606141356.0b86d6b4@kitsune.suse.cz>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <95f92a95-6592-27a2-a822-d3a047cf8339@redhat.com>
Date: Wed, 6 Jun 2018 15:14:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180606141356.0b86d6b4@kitsune.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oCtVnVWg6YxnUNlIpbA6ItmGzUS8bTf8v"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oCtVnVWg6YxnUNlIpbA6ItmGzUS8bTf8v
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <95f92a95-6592-27a2-a822-d3a047cf8339@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180518180440-mutt-send-email-mst@kernel.org>
 <20180524113251.GB4660@redhat.com>
 <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
 <20180528183058.GG2209@redhat.com>
 <20180528183833.GJ4580@localhost.localdomain>
 <20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606131929.44d0fd6b@kitsune.suse.cz>
 <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
 <20180606134327.05de9616@kitsune.suse.cz>
 <94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
 <20180606141356.0b86d6b4@kitsune.suse.cz>
In-Reply-To: <20180606141356.0b86d6b4@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 14:13, Michal Such=C3=A1nek wrote:
> On Wed, 6 Jun 2018 13:52:35 +0200
> Max Reitz <mreitz@redhat.com> wrote:
>=20
>> On 2018-06-06 13:43, Michal Such=C3=A1nek wrote:
>>> On Wed, 6 Jun 2018 13:32:47 +0200
>>> Max Reitz <mreitz@redhat.com> wrote:
>>>  =20
>>>> On 2018-06-06 13:19, Michal Such=C3=A1nek wrote: =20
>>>>> On Wed, 6 Jun 2018 13:02:53 +0200
>>>>> Max Reitz <mreitz@redhat.com> wrote:

[...]

>>>>>> What I'm trying to get at is that qcow2 was not designed to be a
>>>>>> container format for arbitrary files.  If you want to make it
>>>>>> such, I'm sure there are existing formats that work better.   =20
>>>>>
>>>>> Such as?   =20
>>>>
>>>> ext2? =20
>>>
>>> So you want an ext2 driver in qemu instead of expanding qcow2 to
>>> work not only for a single disk but also for an appliance? =20
>>
>> Yes, because ext2 was designed to be a proper filesystem.  I'm not an
>> FS designer.  Well, not a good one anyway.  So I don't trust myself on=

>> extending qcow2 to be a good FS -- and why would I, when there are
>> already numerous FS around.
>=20
> Do you expect that performance of qemu using qcow2 driver over ext2
> driver will be better than using qcow driver directly with some part
> semi-permanently occupied by a configuration blob? My bet is not.

If you want to store multiple disk images in a single file?  I would
think so, yes.  With qcow2, I would assume it leads to fragmentation.  I
would hope that proper filesystems can mitigate this.
> The ext* drivers are designed to work with kernel VM infrastructure
> which must be tuned for different usage scenarios and you would have to=

> duplicate that tuning in qemu to get competitive performance. Also you
> get qcow2 and ext2 metadata which must be allocated, managed, etc. You
> get more storage and performance overhead for no good reason.

Yes, there is a good reason.  You can add arbitrary configuration
options without having to worry about me.

Seriously, though, a real FS would allow you to be more expressive and
really do what you want without having to work around the quirks that
adding a not-real-FS in the most simple way possible to qcow2 would
bring with it.

Because this is part of my fear, that we now add a very simple blob for
just a sprinkle of data.  But over time it gets more and more complex
because we want to store more and more data to make things ever more
convenient[1], we notice that we need more features, the format gets
more complex, and in the end we have an FS that is just worse than a
real FS.

[1] And note that if I'm convinced to store VM configuration data in
qemu, I will agree that we can store any data in there and it would be
nice if any VM could be provisioned and used that way.

> On the other hand, qcow is designed for storing VM disk data and
> hopefully was tuned to do that decently over the years. The primary use=

> case remains storing VM disk data. Adding a configuration blob does not=

> change that.

True.  So the argument is that qcow2 may be worse for storing arbitrary
data, but we don't have performance requirements for that; but we do
have performance requirements for disk data and adding another format
below qcow2 will not make it better.

I do think it is possible to not make things worse with a format under
qcow2, but that may require additional complexity, that you think is
pointless.

I understand that you think that, but I still believe that putting the
configuration into qcow2 is just the wrong way around and will fall on
our feet in the long run.

>>>>>>>> Unless I have got something terribly wrong (which is indeed a
>>>>>>>> possibility!), to me this proposal means basically to turn
>>>>>>>> qcow2 into (1) a VM description format for qemu, and (2) to
>>>>>>>> turn it into an archive format on the way.     =20
>>>>>>>
>>>>>>> And if you go all the way you can store multiple disks along
>>>>>>> with the VM definition so you can have the whole appliance in
>>>>>>> one file. It conveniently solves the problem of synchronizing
>>>>>>> snapshots across multiple disk images and the question where to
>>>>>>> store the machine state if you want to suspend it.      =20
>>>>>>
>>>>>> Yeah, but why make qcow2 that format?  That's what I completely
>>>>>> fail to understand.
>>>>>>
>>>>>> If you want to have a single VM description file that contains
>>>>>> the VM configuration and some qcow2/raw/whatever files along
>>>>>> with it for the guest disk data, sure, go ahead.  But why does
>>>>>> the format of the whole thing need to be qcow2?   =20
>>>>>
>>>>> Because then qemu can access the disk data from the image directly
>>>>> without any need for extraction, copying to different file,
>>>>> etc.   =20
>>>>
>>>> This does not explain why it needs to be qcow2.  There is
>>>> absolutely no reason why you couldn't use qcow2 files in-place
>>>> inside of another file. =20
>>>
>>> qemu cannot read the disk data from the file in-place. =20
>>
>> Hu?  Why not?
>=20
> Well, it can possibly read the image if it happens to be continuous. It=

> will not be able to update it without a fs driver, however.

Yes, but first, such an FS driver would be possible (and as long as we
don't need real complexity, it could be very simple, like just using an
offset in a tar file and then just adjust the file length field on
allocations beyond the EOF).

And secondly, I think adding another format has the advantage of easier
deprecation.  If we think we need something more complex, we are free to
design that and throw away the old format.  But if we add something to
qcow2, I would think it is there to stay.

So, yes, for qcow2 we might want to design something (overly?) complex
from that start that we hope will fulfill all our needs (which it won't,
because things never turn out that way).  But if we'd add a new format,
we could keep it simple in the beginning and start over later.

Max


--oCtVnVWg6YxnUNlIpbA6ItmGzUS8bTf8v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsX3hsACgkQ9AfbAGHV
z0BN0Qf/YMoB9jJHr6O6diLE1fdmt4BmjWaWUs6gEKmWoZN+QQwDmk3MKcyDetpR
r/UJ+zThFsncqk50xc/3+zOcJjsFkOY5zzksoTvRzQzPmgOpLPpZb4dt7e0aYDmg
yQrAQeS3aCe6dBEfQuGbfAM5GbKiMT4pyyuBZ6hJn6zx045HgFzYi28ESpdiidyt
eqgBnQVd42gD2EoE0TKRhlDvKPF4MJxAX1e5erubtCd9iuSYdpduO5dOCu8D3UeX
Ovlgw2gR4Ygf6vsO0CuehH4WwOJOkcFAUiUFxNalEMRipcmDnrin6Hu9B0ypRNBS
iduwNRHJvEKGt91ZzR+u3KSC5G7L9A==
=W3O8
-----END PGP SIGNATURE-----

--oCtVnVWg6YxnUNlIpbA6ItmGzUS8bTf8v--

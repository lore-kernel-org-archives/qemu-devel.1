Received: from eggs.gnu.org ([2001:4830:134:3::10]:53591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQcm6-00028d-JG
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQcm4-0008Qo-LI
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:03:10 -0400
References: <20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606121624.GD2661@work-vm>
	<2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
	<20180606140233.GF2660@work-vm>
	<66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
	<20180606144140.GH2660@work-vm>
	<cea4f615-c768-7a2f-3849-5dd00c37b537@redhat.com>
	<20180606172523.3816a882@kitsune.suse.cz>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a1d7851c-e01f-4190-cc8f-af98531e6379@redhat.com>
Date: Wed, 6 Jun 2018 20:02:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180606172523.3816a882@kitsune.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Z5MMMETAJw5opmgzB3UpT0DQRZyj2b3q9"
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z5MMMETAJw5opmgzB3UpT0DQRZyj2b3q9
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones"
 <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <a1d7851c-e01f-4190-cc8f-af98531e6379@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606131929.44d0fd6b@kitsune.suse.cz>
 <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
 <20180606113720.GA2661@work-vm>
 <2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
 <20180606121624.GD2661@work-vm>
 <2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
 <20180606140233.GF2660@work-vm>
 <66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
 <20180606144140.GH2660@work-vm>
 <cea4f615-c768-7a2f-3849-5dd00c37b537@redhat.com>
 <20180606172523.3816a882@kitsune.suse.cz>
In-Reply-To: <20180606172523.3816a882@kitsune.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 17:25, Michal Such=E1nek wrote:
> On Wed, 6 Jun 2018 16:55:08 +0200
> Max Reitz <mreitz@redhat.com> wrote:
>=20
>> On 2018-06-06 16:41, Dr. David Alan Gilbert wrote:
>>> * Max Reitz (mreitz@redhat.com) wrote: =20
>>
>> [...]
>>
>>>> So why is it so dangerous to connect a disk you just downloaded to
>>>> e.g. the wrong machine type?  I assumed it just wouldn't work and
>>>> you'd try again, until you realized that maybe you should read the
>>>> download description and do as it says ("download this config
>>>> file, pass it"). =20
>>>
>>> That's bad!  Stuff should just-work; =20
>>
>> That's how it always should be.  Life's tough, though.
>>
>>>                                      it currently just works, =20
>>
>> Due to sheer blind luck, I'd say.
>=20
> It's TimeProvenSolution(tm).
>=20
>>
>>>                                                               things
>>> should get better and easier for our users. =20
>>
>> Users using a whole VM stack plus management, but then handling two
>> files instead of one is too much to ask?
>=20
> What you don't seem to realize is there are cases when there is an
> 'administrator' who has set up the VM stack plus management and 'joe
> user' who wants to run some random VM on that stack.
>=20
> And if you download an appliance compatible with the stack it should
> just work. For a long time the 'appliance' for qemu based
> virtualization was a simple qcow2 file which was sized sufficiently for=

> the VM to run but shrunk for transport. And although it is technically
> wrong it JustWorked(tm).

Hm, yes.  As I replied to Dave, I understand, but I would think this
then requires a real appliance solution.  I think you do want such a
solution, but Dave doesn't.

My problem is that I cannot accept Dave's arguments on why to include
this blob in qcow2 if someone else already plans on making that blob the
basis for qcow2 appliances.

And I still do not think that qcow2 is the right format for VM
appliances.  To convince me, we'd first need a consensus on what the
appliances are for (Michael seems to want them for qemu directly,
apparently you want them for something higher up the stack) and thus
what they are supposed to be capable of exactly.

Like, one thing that is important to discuss is this (but please not in
this thread...): If we agree on making an appliance format (qcow2 or
not), is it for running VMs off or do we just want it for VM
export/import?  The former might mean we need qcow2, because there is no
good way to offer good performance with multiple disks otherwise (but
this would constrain us e.g. in the disk image format -- no raw images
for you, then).  But the latter can work just fine with a normal
archival format as long as building/decomposing it is possible without
copying.

(I would think that you can move blocks from one file to another, so
with proper alignment you should be able to build/decompose an archive
from/into its members without copying.)

>>>                                              And anyway, not
>>> working for EFI for exmaple can be just a blank screen.  Seriously
>>> - keep it easy for the user! =20
>>
>> Thinking this through makes you end up with appliances.
>=20
> And those can in general have more than one disk.

Indeed.  And thus knowing what we want is important so we can make a
good decision on where to store it instead of just focusing on where it
would be apparently simplest.

Max


--Z5MMMETAJw5opmgzB3UpT0DQRZyj2b3q9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsYIc4ACgkQ9AfbAGHV
z0CSmwf/bT1WNOCXdHFNATWUHHb2bGYZZCW8fmY2SUxwS/EMmC70nvJZi8TXN63d
G6Y/Xq/52tL6kHqMbWnrKYRkxESJLnEO54Nzkoyk1vJ5G6UVubEzx+SzE/0QTh7w
bNn1SPeKSFu1ywF+J2RIoj9UvNS5XKZakbjuHTAKMT2+nlzzn9byUOiC4MYs1dLQ
/3L7UJI17kt9cKxOj/VvnCK4AzNasBIV4kxWV04u/zAdDJBm5GJ7CxSInjCvgP1k
eeF8Hek1JdxWBjDaw+IT++jVXi9N7H1FMKUjGL5ebU2QHrZJZFwcw+cTY42d4U7B
9RHSgHOGG8Wt726ohVaeE3xsUOWmpw==
=NLdq
-----END PGP SIGNATURE-----

--Z5MMMETAJw5opmgzB3UpT0DQRZyj2b3q9--

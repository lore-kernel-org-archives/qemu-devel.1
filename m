Received: from eggs.gnu.org ([2001:4830:134:3::10]:35574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYi9I-0008Hv-Eb
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYi9H-00082p-LN
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:47:44 -0500
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
	<20170122142959.GA12419@lemon.Home>
	<ff2fd02a-09ea-a28f-eb6e-e1858efff552@redhat.com>
	<20170124120957.GC13714@lemon.Home>
	<e63adc3a-ca01-705a-c21a-d3ead5eb4472@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b57d8de7-394d-5446-8d5b-ea4e0ec85cc3@redhat.com>
Date: Wed, 1 Feb 2017 00:47:33 +0100
MIME-Version: 1.0
In-Reply-To: <e63adc3a-ca01-705a-c21a-d3ead5eb4472@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oPHLkdTcXkpdkIVUqPGwnQFhwg43MxDtl"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/3] scsi-generic and
 BLKSECTGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oPHLkdTcXkpdkIVUqPGwnQFhwg43MxDtl
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <b57d8de7-394d-5446-8d5b-ea4e0ec85cc3@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH v3 0/3] scsi-generic and
 BLKSECTGET
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
 <20170122142959.GA12419@lemon.Home>
 <ff2fd02a-09ea-a28f-eb6e-e1858efff552@redhat.com>
 <20170124120957.GC13714@lemon.Home>
 <e63adc3a-ca01-705a-c21a-d3ead5eb4472@redhat.com>
In-Reply-To: <e63adc3a-ca01-705a-c21a-d3ead5eb4472@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 31.01.2017 12:37, John Snow wrote:
>=20
>=20
> On 01/24/2017 07:09 AM, Fam Zheng wrote:
>> On Tue, 01/24 12:23, Paolo Bonzini wrote:
>>>
>>>
>>> On 22/01/2017 15:29, Fam Zheng wrote:
>>>> On Fri, 01/20 17:25, Eric Farman wrote:
>>>>> Changes:
>>>>>  v2->v3:
>>>>>   - Move byte/sector conversions to patch 2 [Fam Zheng]
>>>>>   - Rename "max_sectors" when holding a byte value [Fam Zheng]
>>>>>  v1->v2:
>>>>>   - Patch 3, make hdev_get_max_transfer_length return bytes [Fam Zh=
eng]
>>>>
>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>
>>> Looks good, who's merging this? :)
>>
>> All I know is not me :) Adding Kevin and Max who maintain block/file-p=
osix.c.
>>
>> Fam
>>
>=20
> Kevin's traveling for DevConf.cz, so how about Max? :)

Did Kevin tell you to write that? If so, tell him he's got to merge all
of my patches once he's back. :-P

Ooooh, I see, he's trying to get me to merge so many patches I'll have
to send my own pull request. Cleverrr. Verrry clever. ;-)

Max


--oPHLkdTcXkpdkIVUqPGwnQFhwg43MxDtl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRIhUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AescIALesBYRtkVZSVpmMhi14r4LfrivUwkyV
qw1b8heHCOYHSn9VmPj+aE/WJPWs9cZ4ZC4cW+w0ZQ40AsALtlhz370X3z7Y1LEK
G5DIwGBuw/lMIjX7YqSGFCf23pjQtTbrhlW4bdsxhIBf2m0rSAp39MJfOuL/HIIl
sBLYlo3r927sIsK3HjVyNfNx8xt7B9Q/uN6A2wkXHhHNTf8F6hQOpr9CRfWzSxAp
FkmV0l15mFsD29kgtJbnpnn0ollXQV6abADF5CwKm23b6bb0K0WX91St1sPcBYLe
zcCZNl+yuiYN3Dux5MR22DDc39de0qQbzent2QZivML/y0Ee7hp7C6M=
=jXne
-----END PGP SIGNATURE-----

--oPHLkdTcXkpdkIVUqPGwnQFhwg43MxDtl--

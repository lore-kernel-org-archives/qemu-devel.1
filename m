Received: from eggs.gnu.org ([2001:4830:134:3::10]:58490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cdyid-0007vD-I9
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cdyia-0005eS-EJ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:29:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35761
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cdyia-0005eJ-7H
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:29:56 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1FCSfbE090251
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 07:29:55 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28mjx7hu4v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 07:29:54 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 15 Feb 2017 12:29:52 -0000
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<20170203103316.GA29200@stefanha-x1.localdomain>
	<20170203173607-mutt-send-email-mst@kernel.org>
	<1fdc2663-2090-9e19-5ea9-1f5b8eef4eb1@linux.vnet.ibm.com>
	<20170213134149.GB10361@stefanha-x1.localdomain>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 13:28:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170213134149.GB10361@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ODgBf7fHe7S6893d8lsdLhkgV7OT4kduJ"
Message-Id: <1fbe30cc-87ec-32bc-4c57-85f9b03b3034@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v16 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, weidong.huang@huawei.com, qemu-devel@nongnu.org, john.griffin@intel.com, jianjay.zhou@huawei.com, Varun.Sethi@freescale.com, denglingli@chinamobile.com, arei.gonglei@hotmail.com, virtio-dev@lists.oasis-open.org, agraf@suse.de, Gonglei <arei.gonglei@huawei.com>, nmorey@kalray.eu, longpeng2@huawei.com, vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com, xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com, cornelia.huck@de.ibm.com, Jani.Kokkonen@huawei.com, brian.a.keating@intel.com, claudio.fontana@huawei.com, mike.caraman@nxp.com, wu.wubin@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ODgBf7fHe7S6893d8lsdLhkgV7OT4kduJ
From: Halil Pasic <pasic@linux.vnet.ibm.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, weidong.huang@huawei.com,
 qemu-devel@nongnu.org, john.griffin@intel.com, jianjay.zhou@huawei.com,
 Varun.Sethi@freescale.com, denglingli@chinamobile.com,
 arei.gonglei@hotmail.com, virtio-dev@lists.oasis-open.org, agraf@suse.de,
 Gonglei <arei.gonglei@huawei.com>, nmorey@kalray.eu, longpeng2@huawei.com,
 vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com,
 xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com,
 cornelia.huck@de.ibm.com, Jani.Kokkonen@huawei.com,
 brian.a.keating@intel.com, claudio.fontana@huawei.com, mike.caraman@nxp.com,
 wu.wubin@huawei.com
Message-ID: <1fbe30cc-87ec-32bc-4c57-85f9b03b3034@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v16 1/2] virtio-crypto: Add virtio crypto
 device specification
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
 <1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
 <20170203103316.GA29200@stefanha-x1.localdomain>
 <20170203173607-mutt-send-email-mst@kernel.org>
 <1fdc2663-2090-9e19-5ea9-1f5b8eef4eb1@linux.vnet.ibm.com>
 <20170213134149.GB10361@stefanha-x1.localdomain>
In-Reply-To: <20170213134149.GB10361@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 02/13/2017 02:41 PM, Stefan Hajnoczi wrote:
> On Fri, Feb 03, 2017 at 07:07:02PM +0100, Halil Pasic wrote:
>>
>>
>> On 02/03/2017 04:37 PM, Michael S. Tsirkin wrote:
>>> On Fri, Feb 03, 2017 at 10:33:16AM +0000, Stefan Hajnoczi wrote:
>>>>> +\begin{description}
>>>>> +\item[0] dataq1
>>>>> +\item[\ldots]
>>>>> +\item[N-1] dataqN
>>>>> +\item[N] controlq
>>>>> +\end{description}
>>>>> +
>>>>> +N is set by \field{max_dataqueues}.
>>>>> +
>>>>> +\subsection{Feature bits}\label{sec:Device Types / Crypto Device /=
 Feature bits}
>>>>> +
>>>>> +VIRTIO_CRYPTO_F_NON_SESSION_MODE (0) non-session mode is available=
=2E
>>>>> +VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE (1) non-session mode is av=
ailable for CIPHER service.
>>>>> +VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE (2) non-session mode is avai=
lable for HASH service.
>>>>> +VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE (3) non-session mode is avail=
able for MAC service.
>>>>> +VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE (4) non-session mode is avai=
lable for AEAD service.
>>>>
>>>> Bits 1-4 require bit 0.  Is bit 0 necessary at all?  Or may bits 1-4=
 can
>>>> be eliminated in favor of just bit 0.
>>>
>>> Too late to change it as QEMU released a device with that feature.
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>
>>
>> When was this introduced to QEMU? Can't find it in current master
>> and I do not remember seeing the patches.
>=20
> s/QEMU/Linux/
>=20
> It's in drivers/crypto/virtio/.
>=20


Thanks! Sorry but I could not find the NON_SESSION_MODE in Linus master
(Linux) either, and Michael has stated that a QEMU device was released
with these. I'm still confused. But if it's only Linux, it most likely is=

not interface, so theoretically should not break anything if we change it=

-- should we want to change it.

I think your original questions regarding these feature bits are valid
(and have not been addressed in a satisfactory way yet) by the way.

Halil






--ODgBf7fHe7S6893d8lsdLhkgV7OT4kduJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAEBAgAGBQJYpEm2AAoJEA0vhuyXGx0AhXUQALiT+qUGBdrPEjUQiZh1uWA5
5gkAVPWc9u7zkjUmBBmzLxdPgRvtrXfGgv3eyJgWD1p5fJVSfD0vlBlI9MwrIpvT
hX1RYfuSa/Nb9dQVT3pZFHCaM/LWJp5N5U3nc2WfEP2lIw3D6K70E8AN6sfvWVZq
l2ZE9XC75IlN4kEGfCM7jmqOeYfOwNe5ig03Ci81c4uodGH+IQg+iDtB7+Ra+qBb
Z5dMNVZzM1JnxAxjMJHZKJQSklR5Ds3EOD0Dud2fT0h0jI1ZB8QfSkC8f3TlgyFF
A5YTWtEqw3w9ZIlOxzhJJAvSeNAfgudnooMYNxBSfSuW/MxhSPkNYIVG+uTAzZWy
pAtC1lGVkoHICZ4yYW2+fBMbdeEKLjnqospFpYQPKxJ9lqn0fVgPxd2e72+g2p9F
9Yemg36zHOG1KRQud+ijRriNPVIMGqTKlDWAal44cNuPclDn9xlaEfNBZO33ktEb
NDuqoevG8FMTEl3McAtkbgcao/4qJa8B8SENKAFAjCXDqXj/zinT1nKB07irJX4V
cQHk7W+GPw0ODsxF6d12Ln/CJINASE10b3G202Y7q7H+fqFpgdDNT0Ew8eCw2iFS
RSuMqZ9OwdBhzxCPSYcd4DiBNGQyohZ/M+0eSML4+wCrIh5ks88YqPWZ7Dn6EnzR
e6kStShXjJRNPzT7cxLw
=itQc
-----END PGP SIGNATURE-----

--ODgBf7fHe7S6893d8lsdLhkgV7OT4kduJ--

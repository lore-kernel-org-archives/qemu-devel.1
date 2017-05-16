Received: from eggs.gnu.org ([2001:4830:134:3::10]:45543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dAl9t-00012y-DG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dAl9p-0003Qo-GH
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:41:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dAl9p-0003QV-6E
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:41:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4GMcifp137955
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 18:41:31 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ag7ewf7qk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 18:41:31 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 16 May 2017 23:41:28 +0100
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<20170516153348.GR8498@stefanha-x1.localdomain>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 00:40:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170516153348.GR8498@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="be2Ew6qNsvrCcl3WwqHnevqNqtDB8nT7m"
Message-Id: <300c670c-6116-2882-17a6-f39f9008efd8@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v18 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, wu.wubin@huawei.com, arei.gonglei@hotmail.com, linqiangmin@huawei.com, zhbzg@huawei.com, eety.chen@huawei.com, amy.zhanghuimin@huawei.com, lixiao91@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--be2Ew6qNsvrCcl3WwqHnevqNqtDB8nT7m
From: Halil Pasic <pasic@linux.vnet.ibm.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com,
 denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com,
 Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com,
 liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com,
 mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu,
 vincent.jardin@6wind.com, wu.wubin@huawei.com, arei.gonglei@hotmail.com,
 linqiangmin@huawei.com, zhbzg@huawei.com, eety.chen@huawei.com,
 amy.zhanghuimin@huawei.com, lixiao91@huawei.com
Message-ID: <300c670c-6116-2882-17a6-f39f9008efd8@linux.vnet.ibm.com>
Subject: Re: [virtio-dev] [PATCH v18 1/2] virtio-crypto: Add virtio crypto
 device specification
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
 <1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
 <20170516153348.GR8498@stefanha-x1.localdomain>
In-Reply-To: <20170516153348.GR8498@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 05/16/2017 05:33 PM, Stefan Hajnoczi wrote:
> On Sat, Apr 22, 2017 at 02:23:50PM +0800, Gonglei wrote:
>> +Dataq requests for both session and stateless modes are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_op_data_req_mux {
>> +    struct virtio_crypto_op_header header;
>> +
>> +    union {
>> +        struct virtio_crypto_sym_data_req   sym_req;
>> +        struct virtio_crypto_hash_data_req  hash_req;
>> +        struct virtio_crypto_mac_data_req   mac_req;
>> +        struct virtio_crypto_aead_data_req  aead_req;
>> +        struct virtio_crypto_sym_data_req_stateless   sym_stateless_r=
eq;
>> +        struct virtio_crypto_hash_data_req_stateless  hash_stateless_=
req;
>> +        struct virtio_crypto_mac_data_req_stateless   mac_stateless_r=
eq;
>> +        struct virtio_crypto_aead_data_req_stateless  aead_stateless_=
req;
>> +    } u;
>> +};
>> +\end{lstlisting}
>=20
> Halil touched on this in the discussion: this spec uses a C-like struct=

> syntax but does not define whether unions really affect sizeof(mystruct=
)
> like they would in C or whether you just mean that any of the union
> fields can be used.  This distinction is important so device and driver=

> authors understand the exact memory layout of requests and responses.
>=20
> Please include an explanation about the meaning of "union" in the text.=

>=20

I do not think simple explaining the union will do. I think this
description is bleeding from more wounds. I tried to explain this
while reviewing the implementation here:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03876.html

Unfortunately some technical issues precluded me from posting it
in a timely manner.

@Stefan: Thanks for joining the discussion.

Regards,
Halil


--be2Ew6qNsvrCcl3WwqHnevqNqtDB8nT7m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAEBAgAGBQJZG4AMAAoJEA0vhuyXGx0AYz4QALigiXJreakxtNzwwNKSyYdC
ms4fKrgvbhBJut1AlbmPmyzLHRq7fSU4xAAEddThXDCGrhxxHwUzwd7d/OuAjoQ5
S+PU2rrK6Yg2ZPxxSdHUXPJTsexpO179t8Fwz5m9UuNY1e5GiojaO2y1/z/A0qQy
UvoVubLLjXcLaA+VepCJuj9z5J/VigaEKxGuRn59loczp1bcwBcsRD0RGgrMPpy6
t45BUvaOL3De/cc/yXm9HnUgS+xUfNlD2yvX49RP6N5JxiJshT22GfXJHN78EHy7
jxpgwd3EXslchzq8p1i6DpU6089Zm7o6+IiVcR30Kzv2SNtoLlAAOqb0UArOPrvg
lRYcIltsLzE8Xrzde+kRVWKBs46NfvSaWdhK0L8W/uhbU/9S1lyCF9CQzPqBQrBM
RhIHDHZvgloGuO/1ixc8Pn8CQyg3Fs9Xc73ZQp9F0aTeu8COa2qMclTl1Txn47xB
Df/MfN5groqjhG8QQKn7fz5E4/t1mj4nfh6e+B76YJ21SEmE0tUR9jwreTyxG8r1
w3UXEpZYwwsBADIz7ijINJFPjElceI3ITO5HhRlnfqQbmT9nBMbvrWiFuTNPORWj
lDDjp2ExGgc4Y6IDqno6ScEz8beKZNVBCwNIveS9+hNO6anI5BcVKrAN3V6G0pXy
AIhKxLwWj22MKbSDC45M
=yX2k
-----END PGP SIGNATURE-----

--be2Ew6qNsvrCcl3WwqHnevqNqtDB8nT7m--

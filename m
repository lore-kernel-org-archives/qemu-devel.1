Received: from eggs.gnu.org ([2001:4830:134:3::10]:57812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cTtre-0005KX-7u
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cTtrZ-0000hQ-4R
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:17:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cTtrY-0000fC-QM
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:17:33 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0IHHH5S058468
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 12:17:23 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0a-001b2d01.pphosted.com with ESMTP id 282br7atfa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 12:17:22 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 18 Jan 2017 17:16:49 -0000
References: <1483524185-9036-1-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA174989@DGGEMA505-MBX.china.huawei.com>
	<63cd3678-4044-365d-d396-1040f5755e2c@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA18DE85@DGGEMA505-MBX.china.huawei.com>
	<20170112214414-mutt-send-email-mst@kernel.org>
	<33183CC9F5247A488A2544077AF19020DA18F9A0@DGGEMA505-MBX.china.huawei.com>
	<20170113175828-mutt-send-email-mst@kernel.org>
	<33183CC9F5247A488A2544077AF19020DA1927AA@DGGEMA505-MBX.china.huawei.com>
	<9a9466e5-b626-1ba7-b8c8-65f310961ec4@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA194082@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 18 Jan 2017 18:16:41 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA194082@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <9d62cbf9-104f-895b-00bc-1b77de8c29c0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] RE: [virtio-dev] Re: [PATCH v15 0/2]
 virtio-crypto: virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "john.griffin@intel.com" <john.griffin@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Shiqing Fan <Shiqing.Fan@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>



On 01/17/2017 03:49 AM, Gonglei (Arei) wrote:
> Hi Halil,
> 
>>
>> On 01/16/2017 01:43 PM, Gonglei (Arei) wrote:
>>> Hi Michael and others,
>>>
>>> I'd like to redefine struct virtio_crypto_op_data_req is as below:
>>>
>>> struct virtio_crypto_op_data_req {
>>>     struct virtio_crypto_op_header header;
>>>
>>>     union {
>>>         struct virtio_crypto_sym_data_req   sym_req;
>>>         struct virtio_crypto_hash_data_req  hash_req;
>>>         struct virtio_crypto_mac_data_req   mac_req;
>>>         struct virtio_crypto_aead_data_req  aead_req;
>>>         struct virtio_crypto_sym_data_req_non_sess
>> sym_non_sess_req;
>>>         struct virtio_crypto_hash_data_req_non_sess
>> hash_non_sess_req;
>>>         struct virtio_crypto_mac_data_req_non_sess
>> mac_non_sess_req;
>>>         struct virtio_crypto_aead_data_req_non_sess
>> aead_non_sess_req;
>>> 		__u8 padding[72];
>>>     } u;
>>> };
>>>
>>> The length of union in the structure will be changed, which from current 48
>> byte to 72 byte.

Quoting seems broken :(

>>>
>>> We couldn't redefine a structure named
>> virtio_crypto_op_data_req_non_sess,
>>> Because the feature bits are for crypto services, not for the wrapper packet
>> request.
>>>
>>
>> You mean virtio_crypto_op_data_req.virtio_crypto_op_header.flags
>> are conceptually meant for something else and using that field woulb
>> be misuse?
>>
> Nope...
>>

I'm having huge difficulties following you. Please tell me what was
the intended meaning of the sentence I commented! About which
flags are you talking?

>>> It's impossible to mixed use struct virtio_crypto_op_data_req and
>>> struct named virtio_crypto_op_data_req_non_sess for one data virtqueue.
>>>
>>
>> I do not understand what are you trying to say here. I think you
>> should tell us what is the new feature and how it is guarded.
>>
>> Would this mean that session or non-session mode will be tied
>> to the whole device, or to one data-queue. If it's data-queue
>> level how is it controlled (e.g. control queue)?
>>
> ... I'm so sorry for confusing explanation. Let me try to explain it more clear.

Which explanation? Now I see three ideas as a more clear explanation
where I figured we are discussing one idea.

> 
> 1 ) The first idea: For support non-session mode crypto operations, I introduce 4 feature bits
> for different crypto services, they are:
> 
> VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE (1) non-session mode is available for CIPHER service.
> VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE (2) non-session mode is available for HASH service.
> VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE (3) non-session mode is available for MAC service.
> VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE (4) non-session mode is available for AEAD service.
> 
> but not only one feature bit, something like:
> 
> VIRTIO_CRYPTO_F_ NON_SESSION_MODE (1) non-session mode is available.
> 
> Meanwhile, I define 4 new non-session mode structures for different crypto
> services in order to keep compatibility to pre-existing driver.
> 
> -*Advantages*:
> 
> a) We can support different modes for different crypto services
> according to which features are negotiated.
> 
> b) The driver can still use the session mode when VIRTIO_CRYPTO_F_*_NON_SESSION_MODE are negotiated,
> which is under control by virtio_crypto_op_data_req.virtio_crypto_op_header.flags.
> 
> - *Disadvantages*:
> 
> The current crypto packets of all
> crypto services (CIPHER, HASH, MAC and AEAD) are wrapped in structure
> virtio_crypto_op_data_req by an union in the data plane.
> 
> It will change the length of the union and break the pre-existing code
> if still lay all non-session mode structures in strut virtio_crypto_op_data_req
> like this:
> 
> struct virtio_crypto_op_data_req {
>     struct virtio_crypto_op_header header;
> 
>     union {
>         struct virtio_crypto_sym_data_req   sym_req;
>         struct virtio_crypto_hash_data_req  hash_req;
>         struct virtio_crypto_mac_data_req   mac_req;
>         struct virtio_crypto_aead_data_req  aead_req;
>         struct virtio_crypto_sym_data_req_non_sess   sym_non_sess_req;
>         struct virtio_crypto_hash_data_req_non_sess  hash_non_sess_req;
>         struct virtio_crypto_mac_data_req_non_sess   mac_non_sess_req;
>         struct virtio_crypto_aead_data_req_non_sess  aead_non_sess_req;
> 		__u8 padding[72];
>     } u;
> };

Yeah if you say a request has to look like this regardless
of negotiated features, then you render the currently upstream
code non-conform. That's pretty much a decisive disadvantage!

> 
> So I should submit patches to fix them.

And IMHO you can not fix that with patches because it's already
released -- and you would have to travel back in time to fix
it in time.

> 
> 2) Another idea is define a non-session mode structure for strut virtio_crypto_op_data_req.
> 
> struct virtio_crypto_op_data_req_non_sess {
>     struct virtio_crypto_op_header header;
> 
>     union {
>         struct virtio_crypto_sym_data_req_non_sess   sym_non_sess_req;
>         struct virtio_crypto_hash_data_req_non_sess  hash_non_sess_req;
>         struct virtio_crypto_mac_data_req_non_sess   mac_non_sess_req;
>         struct virtio_crypto_aead_data_req_non_sess  aead_non_sess_req;
> 		__u8 padding[72];
>     } u;
> };
> 
> And keep the pre-existing strut virtio_crypto_op_data_req:
> 
> struct virtio_crypto_op_data_req {
>     struct virtio_crypto_op_header header;
> 
>     union {
>         struct virtio_crypto_sym_data_req   sym_req;
>         struct virtio_crypto_hash_data_req  hash_req;
>         struct virtio_crypto_mac_data_req   mac_req;
>         struct virtio_crypto_aead_data_req  aead_req;
> 		__u8 padding[48];
>     } u;
> };
> 
> - *Advantages*: 
> 
> Don't break the pre-existing code.
> 
> - *Disadvantages*: 
> 
> Can't support feature bits for different crypto services,
> only the whole device. That means we should only use the below feature

I do not see why, and I do not see why should we want to have
separate feature bits for each service.

> bit:
> 
> VIRTIO_CRYPTO_F_ NON_SESSION_MODE (1) non-session mode is available.
> 
> 
> 3) The last idea is define a mixed structure for strut virtio_crypto_op_data_req.
> 
> struct virtio_crypto_op_data_req_mixed {
>     struct virtio_crypto_op_header header;
> 
>     union {
>         struct virtio_crypto_sym_data_req   sym_req;
>         struct virtio_crypto_hash_data_req  hash_req;
>         struct virtio_crypto_mac_data_req   mac_req;
>         struct virtio_crypto_aead_data_req  aead_req;
>         struct virtio_crypto_sym_data_req_non_sess   sym_non_sess_req;
>         struct virtio_crypto_hash_data_req_non_sess  hash_non_sess_req;
>         struct virtio_crypto_mac_data_req_non_sess   mac_non_sess_req;
>         struct virtio_crypto_aead_data_req_non_sess  aead_non_sess_req;
> 		__u8 padding[72];
>     } u;
> };
> 
> And keep the pre-existing strut virtio_crypto_op_data_req:
> 
> struct virtio_crypto_op_data_req {
>     struct virtio_crypto_op_header header;
> 
>     union {
>         struct virtio_crypto_sym_data_req   sym_req;
>         struct virtio_crypto_hash_data_req  hash_req;
>         struct virtio_crypto_mac_data_req   mac_req;
>         struct virtio_crypto_aead_data_req  aead_req;
> 		__u8 padding[48];
>     } u;
> };
> 
> That means we should use below five feature bits:
> 
> VIRTIO_CRYPTO_F_ NON_SESSION_MODE (0) non-session mode is available.
> VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE (1) non-session mode is available for CIPHER service.
> VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE (2) non-session mode is available for HASH service.
> VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE (3) non-session mode is available for MAC service.
> VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE (4) non-session mode is available for AEAD service.
> 
> -*Advantages*:
> 
> Both idea 1) and 2).
> 
> -*Disadvantages*:
> 
> None.
> 
> What's your opinion? Thanks a lot!
> 
> 

You kindly forget to tell us how it is to be decided which of the unioned
types is actually relevant for an instance. And also forget to tell
us which struct is used under which circumstances (that is feature
bits).

Well it does not matter. Have seen v16 and there you went for idea 3,
and decided to use virtio_crypto_op_header.flags to decide if we
have a session based or a stateless request at hand if feature bits
allow both. I will try to do a proper review there.

My opinion is that you should be more precise when describing
your ideas if you want to hear a more constrictive opinion than
this one. 

Cheers,
Halil

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6df4-0007E3-NH
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6df1-000094-Hq
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:52:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6df1-00007c-8X
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:52:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45DnC2g016672
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 09:52:41 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8hf0shmr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 09:52:41 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 14:52:36 +0100
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<38d13582-47f4-2a03-efef-064063c8852f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA263F82@DGGEMA505-MBX.china.huawei.com>
	<17594b34-62c0-bc4e-2fda-fc54837e0732@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA264026@DGGEMA505-MBX.china.huawei.com>
	<40d5eb58-0f6a-5da4-83d2-656f0abfcf0f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA26484F@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 5 May 2017 15:52:27 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA26484F@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <b0c98f49-fdec-a431-30c5-36512b198606@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] RE: [PATCH v18 1/2] virtio-crypto:
 Add virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "lixiao (H)" <lixiao91@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Zhbzg <zhbzg@huawei.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Linqiangmin <linqiangmin@huawei.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Chenshanxi (Eety Chen, Euler)" <eety.chen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>



On 05/05/2017 05:39 AM, Gonglei (Arei) wrote:
>>
>>
>> On 05/04/2017 04:13 PM, Gonglei (Arei) wrote:
>>>>
>>>>
>>>> On 05/04/2017 03:33 PM, Gonglei (Arei) wrote:
>>>>>>> +\begin{description}
>>>>>>> +\item[VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE] Requires
>>>>>> VIRTIO_CRYPTO_F_STATELESS_MODE.
>>>>>>> +\item[VIRTIO_CRYPTO_F_HASH_STATELESS_MODE] Requires
>>>>>> VIRTIO_CRYPTO_F_STATELESS_MODE.
>>>>>>> +\item[VIRTIO_CRYPTO_F_MAC_STATELESS_MODE] Requires
>>>>>> VIRTIO_CRYPTO_F_STATELESS_MODE.
>>>>>>> +\item[VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE] Requires
>>>>>> VIRTIO_CRYPTO_F_STATELESS_MODE.
>>>>>>> +\end{description}
>>>>>>
>>>>>> I find feature bit 0 redundant and bit confusing. We had a discussion
>>>>>> in v15 and v16.
>>>>>>
>>>>>> Could you answer:
>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03214.html
>>>>>> (Message-ID:
>>>> <1fbe30cc-87ec-32bc-4c57-85f9b03b3034@linux.vnet.ibm.com>)
>>>>>>
>>>>>>
>>>>> Please see my reply:
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03186.html
>>>>>
>>>>> The main reason is we should keep compatibility to pre-existing driver and
>>>>> support some function that different services have different modes.
>>>>> We have only one unique crypto request named structure
>>>> virtio_crypto_op_data_req_mux.
>>>>> Please continue to see the sepc, you'll find the truth.
>>>>>
>>>>
>>>> Sorry, I still do not understand why can't we drop
>>>> VIRTIO_CRYPTO_F_STATELESS_MODE
>>>> and just keep the four service specific modes.
>>>>
>>>> Can you point me to the (published) code where
>>>> VIRTIO_CRYPTO_F_STATELESS_MODE is
>>>> used (that's what I'm missing -- preferably state the repository, the commit
>>>> a file and a line using VIRTIO_CRYPTO_F_STATELESS_MODE)?
>>>>
>>> No no no, there isn't existing code use VIRTIO_CRYPTO_F_STATELESS_MODE
>> yet,
>>> It's just for future use.
>>>
>>
>> Thanks, that's a crucial piece of information. In the thread I referenced
>> this was not cleared (at least for me). It would be really nice to have
>> some working code before doing the spec, because I find it very easy to miss
>> a detail which renders the whole thing useless if one works solely on
>> theoretical level and does not try to create at least a working prototype.
>>
> I see.
> 
>>> Please the blow description:
>>> """
>>> \drivernormative{\paragraph}{HASH Service Operation}{Device Types / Crypto
>> Device / Device Operation / HASH Service Operation}
>>>
>>> \begin{itemize*}
>>> \item If the driver uses the session mode, then the driver MUST set
>> \field{session_id} in struct virtio_crypto_op_header
>>>       to a valid value assigned by the device when the session was created.
>>> \item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
>> the driver MUST use struct virtio_crypto_op_data_req_mux to wrap crypto
>> requests. Otherwise, the driver MUST use struct virtio_crypto_op_data_req.
>>> \item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is
>> negotiated, 1) if the driver uses the stateless mode, then the driver MUST set
>> the \field{flag} field in struct virtio_crypto_op_header
>>>       to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set the fields
>> in struct virtio_crypto_hash_para_statelession.sess_para, 2) if the driver uses
>> the session mode, then the driver MUST set the \field{flag} field in struct
>> virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATE_MODE.
>>> \item The driver MUST set \field{opcode} in struct virtio_crypto_op_header to
>> VIRTIO_CRYPTO_HASH.
>>> \end{itemize*}
>>> """
>>>
>>> If we drop the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit, and the
>>> VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is not negotiated,
>>> then the driver doesn't to know use which structure to store the crypto
>> request:
>>> is struct virtio_crypto_op_data_req_mux ? or struct
>> virtio_crypto_op_data_req.
>>
>> Thanks for the detailed explanation.
>>
>> Let's clarify some things first:
>> 1) struct virtio_crypto_op_data_req_mux IS NOT a C language struct but
>> a somewhat informal desciption using C-like syntax. If you don't follow
>> try to reason about the size of struct virtio_crypto_op_data_req_mux.
>> For instance look at:
>> +struct virtio_crypto_cipher_data_req_stateless {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_cipher_para_stateless para;
>> +    /* The cipher key */
>> +    u8 cipher_key[keylen];
>> +
>> +    /* Initialization Vector or Counter data. */
>> +    u8 iv[iv_len];
>> +    /* Source data */
>> +    u8 src_data[src_data_len];           <==
>>
>> The  isrc_data_len is not a compile time constant!!
>>
>> +
>> +    /* Device-writable part */
>> +    /* Destination data */
>> +    u8 dst_data[dst_data_len];
>> +    struct virtio_crypto_inhdr inhdr;
>> +};
>>
>> Using something like BNF to describe the requests would be
>> less ambiguous but likely more difficult to read and reason about
>> for most of us (and also inconsistent with the rest of the spec).
>>
> I used to use src_data_gpa/dst_data_gpa to express the data,
> But you thought it's not clear, so I changed to use u8[len] like
> virtio-scsi device in the virtio spec as your suggested.
> 
[..]

That's right, I suggested being consistent there, I'm a bit confused
by this *_gpa stuff though. I guess gpa stands for guest physical
address, so I guess that would mean transmitting only a 'pointer'
to the src_data via the virtq as a part of the request instead of
transmitting a buffer holding the src_data. So IFAIU that would
be a different protocol and not an alternative description of
the same protocol. AFAIK your prototype implementation was
transmitting the data buffer via the virtqueue and not only a pointer
to it. If that's not the case my proposal was utterly wrong!

>> 2) Each struct virtio_crypto_op_data_req is also a struct
>> virtio_crypto_op_data_req_mux
>> in a sense of 1).
>>
>> 3) The header struct virtio_crypto_op_header is a common prefix for
>> struct virtio_crypto_op_data_req and a struct
>> virtio_crypto_op_data_req_mux.
>>
> Yes.
> 
>>
>>>
>>> We assume the driver uses struct virtio_crypto_op_data_req, what about the
>> device?
>>> The device doesn't know how to parse the request in the
>> virtio_crypto_handle_request()
>>> of virito-crypto.c in Qemu.
>>>
>>> static int
>>> virtio_crypto_handle_request(VirtIOCryptoReq *request)
>>> {
>>>     VirtIOCrypto *vcrypto = request->vcrypto;
>>>     VirtIODevice *vdev = VIRTIO_DEVICE(vcrypto);
>>>     VirtQueueElement *elem = &request->elem;
>>>     int queue_index =
>> virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
>>>     struct virtio_crypto_op_data_req req; ???
>>>
>>>     ///or struct virtio_crypto_op_data_req_mux req; ???
>>>
>>
>> Because of 3) and because the service associated with the request can be
>> inferred
>> form virtio_crypto_op_header one can answer the question you as, and decide
>> if what comes after the header is a stateless or a session variant based
>> on virtio_crypto_op_header.flag -- maybe it does not even need opcode
>> to do that.
>>
> Yes, you are right. We can get the common header:
> 
> static int
> virtio_crypto_handle_request(VirtIOCryptoReq *request)
> {
> ...
> struct virtio_crypto_op_header header;
> 
> iov_to_buf(out_iov, out_num, 0, &header, sizeof(header));
> 
> ...
> 
> Then we check the header.flag: 
> 
> If (header.flag == VIRTIO_CRYPTO_FLAG_STATELESS_MOD) {
>   //Use struct virtio_crypto_op_data_req_mux req;
> } else if (header.flag == VIRTIO_CRYPTO_FLAG_SESSION_MOD) {
>   //Use struct virtio_crypto_op_data_req_mux req;
> } else {
>   //Use struct virtio_crypto_op_data_req req;
> }
> 
> But for existing code we don't use the header.flag to check the request, 
> Will it break the pre-existing code? Because we don't assume header.flag is
> zero before.
> 

That's a very good question, and it relates well to our discussion about
the algorithm bits. You say, the problem is that the published QEMU
implementation does not reject 'unknown' flags (that is requests having
unknown flags).

In pure theory, that ain't really a problem, because we can first look at
the op_code and only check the MOD flags if stateless feature bit was set
for that op_code (service). That way a (IMHO buggy) driver could continue
happily writing garbage into flag for session requests for any service if
it does not negotiate the stateless bit for that service.

Thus I think omitting VIRTIO_CRYPTO_F_HASH_STATELESS_MODE (using 4
feature bits for stateless) is theoretically possible. Do you agree?

But let's approach the problem from the header.flag perspective.

I see two ways for handling the problem you describe.
1) The device MUST ignore header.flag bit's not explicitly activated
by the presence of some condition involving feature bits, and MUST
honor activated ones.
2) We guard the header.flag (and possibly other stuff we forgot to
handle) must not have unknown bits with a feature bit. That is
the device MUST reject unknown bits. But even if we do this we still
need a feature bit based mechanism for adding new known bits. And
since we have a version out there with no flags defined we would
need to guard (that is 'activate' from 1)) at least the flags
introduced together.

Option 2) from above is probably an over-complication, so we should
probably go with 1).

I do not think 1) is correctly described in the spec because we miss MUST
ignore. This MUST ignore is analogous to the MUST ignore in 'The device
MUST ignore the used_event value' from 2.4.7.2 Device Requirements: 
Virtqueue Interrupt Suppression. Maybe replacing this MUST with two SHOULDs
is viable too (the driver SHOULD not send garbage and the device SHOULD
ignore garbage), but I think we need something. Do you agree?

Even if using just 4 feature bits for stateless is possible it does not
mean we that's the best way, but VIRTIO_CRYPTO_F_STATELESS_MODE is a
slightly confusing name given its semantic. If we examine how
VIRTIO_CRYPTO_F_STATELESS_MODE negotiated affects the protocol, we have
to conclude that it changes the request format on the data queues: if
negotiated you have to use _mux if not you must not use _mux. If you use
_mux you MUST set VIRTIO_CRYPTO_F_STATELESS_MODE for session requests, if
you do not use _mux you do not (here you == the driver). So it impacts
session requests too. My problem other problem with the name is that
VIRTIO_CRYPTO_F_STATELESS_MODE does not mean we can use stateless mode,
and that's counter-intuitive for me.

Honestly I have to think about the how formulations impact our ability to
extend the protocol some more myself. So sorry if I'm generating too much
noise.

Regards,
Halil

> 
>> Thus (IMHO) dropping VIRTIO_CRYPTO_F_STATELESS_MODE is possible.
>>
>> Or is there a flaw in my reasoning?
>>
> 
> Thanks,
> -Gonglei
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

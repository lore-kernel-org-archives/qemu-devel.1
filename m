Received: from eggs.gnu.org ([2001:4830:134:3::10]:40686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ew4yG-0001IL-Ix
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ew4yD-000353-I2
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:53:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ew4yD-00034o-CR
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:53:25 -0400
Received: by mail-wr0-f193.google.com with SMTP id f14so4427066wre.8
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 04:53:25 -0700 (PDT)
References: <20180313224719.4954-1-pbonzini@redhat.com>
	<152098654112.42.12932252584766342295@71c20359a636>
	<20180314033531.GL11787@xz-mi>
	<b4176553-befd-3404-25a0-c48ee70c13b4@redhat.com>
	<9fe6e4b1-6a9a-39c5-0f4c-4df09583f875@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aaf9ce33-6fbd-0948-9bcc-cb6fa4c40e81@redhat.com>
Date: Wed, 14 Mar 2018 12:53:21 +0100
MIME-Version: 1.0
In-Reply-To: <9fe6e4b1-6a9a-39c5-0f4c-4df09583f875@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/69] Misc patches for QEMU soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On 14/03/2018 12:30, Eric Blake wrote:
> On 03/14/2018 05:12 AM, Paolo Bonzini wrote:
> 
>>>> Checking PATCH 16/69: chardev: tcp: postpone async connection setup...
>>>> Checking PATCH 17/69: chardev: tcp: let TLS run on chardev context...
>>>
>>> It seems that Dan's last patch is still missing in the pull
>>> request:
>>>
>>> http://patchwork.ozlabs.org/patch/883155/
>>
>> Yes, this is a pull request I prepared last Monday and forgot to send.
>> I'll send that out separately, it's a bugfix so it can be submitted
>> after soft freeze.
> 
> Or, since my pre-freeze QAPI pull request needs a v2, I can include it
> there, if I have an ACK or R-b by Paolo.

Sure, go ahead and include it!

Paolo

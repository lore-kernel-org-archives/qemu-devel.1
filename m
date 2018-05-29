Received: from eggs.gnu.org ([2001:4830:134:3::10]:58355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNbeV-0000iR-Bq
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNbeU-0004Xn-JA
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:14:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fNbeU-0004Wa-EK
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:14:50 -0400
References: <20180529073140.7392-1-zyimin@linux.ibm.com>
	<20180529093940.GA19798@vader>
	<b235d751-f222-af7b-b814-c499416f7706@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52580f00-40ab-036a-a1df-a1dc49e7022f@redhat.com>
Date: Tue, 29 May 2018 12:14:47 +0200
MIME-Version: 1.0
In-Reply-To: <b235d751-f222-af7b-b814-c499416f7706@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>, Eduardo Otubo <otubo@redhat.com>
Cc: fiuczy@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org, jtomko@redhat.com, jferlan@redhat.com

On 29/05/2018 11:53, Yi Min Zhao wrote:
>>>
>>> Yi Min
>>>
>> Acked-by: Eduardo Otubo <otubo@redhat.com>
>>
>>
> Thanks! I have included Paolo's squashing code. I'm not sure what I
> should do next, sending a new version?

No need, thanks!

Paolo

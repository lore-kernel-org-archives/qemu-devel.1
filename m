Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dlCO7-0002V4-5I
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dlCO3-0006GJ-Gj
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:02:55 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:45172
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dlCO3-0006FW-AE
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:02:51 -0400
References: <d2c54be0-8eec-9b6f-63e3-c31e487bc7f3@adacore.com>
	<3cf9e9c9-3320-46c2-b8d7-2e77986863d4@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <8b6d287b-850b-fdf8-018c-2a2ccad9bfd5@adacore.com>
Date: Fri, 25 Aug 2017 13:02:47 +0200
MIME-Version: 1.0
In-Reply-To: <3cf9e9c9-3320-46c2-b8d7-2e77986863d4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] RFC: qemu RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, kbastian@mail.uni-paderborn.de

Hi Paolo,

Thanks for the information.

Fred

On 08/23/2017 10:29 PM, Paolo Bonzini wrote:
> On 23/08/2017 21:25, KONRAD Frederic wrote:
>> Hi all,
>>
>> I found somes slides about RISC-V at the KVM forum 2016.
>>
>> Seems the upstreaming process should have started in september 2016 but
>> I didn't see anything.
>>
>> Is that still planed?
> 
> We're waiting from the privileged interface specification to become stable.
> 
> The linux-user emulation could go in now (for some value of now), but
> the RISC-V people wanted to have the system emulation first.
> 
> Paolo
> 

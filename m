Received: from eggs.gnu.org ([209.51.188.92]:60215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h2IlI-0003ZD-6T
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h2IlG-00065D-FM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1h2IlF-00062n-6J
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:18 -0500
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
	<CAFEAcA9_shDqjpqF-k9mvR1N6DY7HmXMPiOpkSFcnGpyC3W7tQ@mail.gmail.com>
	<12a1fc59-da10-174b-6544-3af075da8057@redhat.com>
	<CAFEAcA9kYUAP2fhKRn0GTvx4gXGMyimxeWSD8x6ZNd9HS+0ksQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a83694c0-a473-0d70-430d-c73c33155699@redhat.com>
Date: Fri, 8 Mar 2019 17:54:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9kYUAP2fhKRn0GTvx4gXGMyimxeWSD8x6ZNd9HS+0ksQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 3/8/19 4:53 PM, Peter Maydell wrote:
> On Thu, 21 Feb 2019 at 14:55, Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi,
>> On 2/21/19 3:26 PM, Peter Maydell wrote:
>>> On Thu, 21 Feb 2019 at 14:20, Auger Eric <eric.auger@redhat.com> wrote:
>>>> [a regression using aarch64 KVM]
>>> Can you provide the QEMU_EFI.fd ?
>> I am using upstream EDK2 (https://github.com/tianocore/edk2) compiled in
>> debug mode
> 
> I don't really want to mess about building EDK2. Could you just
> provide the blob that demonstrates the bug, please?

I just sent you the binary in a separate email.

Thanks

Eric
> 
> thanks
> -- PMM
> 

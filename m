Received: from eggs.gnu.org ([2001:4830:134:3::10]:48173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fLC6t-00056L-3A
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fLC6p-0002xS-2S
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:34:11 -0400
Received: from ssl.serverraum.org ([213.133.101.245]:39845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1fLC6o-0002uQ-OQ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:34:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 22 May 2018 20:33:59 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <CAFEAcA_9Cj0smiup_-gCf_QFbyt-kJDEykFMYJ-KMeand9dyWg@mail.gmail.com>
References: <20180521154952.15421-1-michael@walle.cc>
	<CAFEAcA_9Cj0smiup_-gCf_QFbyt-kJDEykFMYJ-KMeand9dyWg@mail.gmail.com>
Message-ID: <0eb5c40aa1e08b7c07706a08c3dc173a@walle.cc>
Subject: Re: [Qemu-devel] [PULL 0/1] target/lm32 BQL patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Am 2018-05-22 12:01, schrieb Peter Maydell:
> On 21 May 2018 at 16:49, Michael Walle <michael@walle.cc> wrote:
>> The following changes since commit 
>> 81e9cbd0ca1131012b058df6804b1f626a6b730c:
>> 
>>   lm32: take BQL before writing IP/IM register (2018-05-21 13:37:12 
>> +0200)
>> 
>> are available in the git repository at:
>> 
>>   git://github.com/mwalle/qemu.git tags/lm32-queue/20180521
> 
> Hi -- this doesn't appear to be a GPG signed tag?
> 

whoops, fixed. I guess I get everything wrong with this 
patch/pullrequest..

-michael

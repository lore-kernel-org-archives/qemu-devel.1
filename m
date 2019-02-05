Received: from eggs.gnu.org ([209.51.188.92]:52341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqz27-0006ND-TM
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqz27-0000ME-7n
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:36:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gqz26-0000Lq-WC
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:36:55 -0500
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9RmsnMTuQU3a4G+Q6=RL9_YOm5Fi-OyVwkX2fTMzvYCA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <014991ae-f48e-4a82-b1d1-2ae3034606cc@redhat.com>
Date: Tue, 5 Feb 2019 12:27:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9RmsnMTuQU3a4G+Q6=RL9_YOm5Fi-OyVwkX2fTMzvYCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/77] Misc patches for 2019-02-04
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

On 05/02/19 10:35, Peter Maydell wrote:
> On Mon, 4 Feb 2019 at 18:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 773c4a6228fd910556cee2d477ee56c591a30000:
>>
>>   test-filter-mirror: pass UNIX domain socket through fd (2019-02-04 16:03:20 +0000)
>>
>> are available in the git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
> 
> Hi; my script says:
> error: remotes/bonzini/tags/for-upstream: cannot verify a non-tag
> object of type commit.
> Does not appear to be a signed tag
> 
> Did something go wrong at your end?

Hmm this is a first.  Repushed now.

Paolo

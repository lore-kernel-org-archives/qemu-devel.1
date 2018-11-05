Received: from eggs.gnu.org ([2001:4830:134:3::10]:49389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gJhs3-00063Q-K5
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gJhry-0000Iy-Ez
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:36:59 -0500
Received: from smtp21.mail.ru ([94.100.179.250]:60558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gJhrx-0007SV-Rw
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:36:54 -0500
References: <20181105104524.933-1-jusual@mail.ru>
	<df0c970c-4180-a9ae-6bb6-5149e93883ae@redhat.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <3cb6fc98-eb70-b601-3fbc-d807282e377c@mail.ru>
Date: Mon, 5 Nov 2018 19:36:04 +0300
MIME-Version: 1.0
In-Reply-To: <df0c970c-4180-a9ae-6bb6-5149e93883ae@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] tests/microbit-test: Check nRF51 UART
 functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05.11.2018 19:16, Philippe Mathieu-Daudé wrote:
> Hi Julia,
> 
> On 5/11/18 11:45, Julia Suvorova via Qemu-devel wrote:
>> Some functional tests for:
>>      Basic reception/transmittion
>>      Suspending
>>      INTEN* registers
>>
>> Based-on: <20181031002526.14262-1-contrib@steffen-goertz.de>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
> 
> Lines below '---' are not included in the git history.
> 
> The Based-on: tag is temporary and not relevant to the history, you should insert it here, so it will be automatically 
> dropped once your patch get applied.

Seems reasonable. I'll do it in the next revision, since I have to
rebase it anyway as soon as Steffen patches will be merged.
BTW, you can find a couple of Based-on in git history :)

Best regards, Julia Suvorova.

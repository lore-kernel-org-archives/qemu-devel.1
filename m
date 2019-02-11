Received: from eggs.gnu.org ([209.51.188.92]:56525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1gt7X9-0006Fs-Jf
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1gt7X7-0002Av-TP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:05:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:58829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1gt7X7-00021F-IL
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:05:45 -0500
References: <20190207115400.647-1-richard.henderson@linaro.org>
	<20190211082150.GA10540@t470p.stackframe.org>
From: Helge Deller <deller@gmx.de>
Message-ID: <5792ec5e-9c0e-e174-d2cb-2e6b41eba580@gmx.de>
Date: Mon, 11 Feb 2019 10:05:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190211082150.GA10540@t470p.stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/19] target/hppa: Convert to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org

On 11.02.19 09:21, Sven Schnelle wrote:
> Hi Richard,
> 
> On Thu, Feb 07, 2019 at 11:53:41AM +0000, Richard Henderson wrote:
> 
>> Helge or Sven, if you have a chance to do a bit more testing in
>> the next week, I would appreciate it.  Otherwise we can fix any
>> other minor problems on mainline.
> 
> I tested this during the weekend with my HP-UX branch and found no
> problems. Feel free to add
> 
> Tested-by: Sven Schnelle <svens@stackframe.org>

No issues found here either:
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

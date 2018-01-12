Received: from eggs.gnu.org ([2001:4830:134:3::10]:38110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1ea1zN-0001JQ-KJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1ea1zK-0003PX-7V
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:15:29 -0500
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<20171218174552.18871-3-richard.henderson@linaro.org>
	<CAFEAcA9igMy9u0WdTBvJWms1G4Cd2m0QXUucJeXCJ1Uo=7OAMw@mail.gmail.com>
	<300b87dc-7a0c-dda9-058d-674b115d06a1@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <7bec8c5f-3454-374f-b2e9-f01890e1996b@mail.uni-paderborn.de>
Date: Fri, 12 Jan 2018 17:12:54 +0100
MIME-Version: 1.0
In-Reply-To: <300b87dc-7a0c-dda9-058d-674b115d06a1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/23] target/arm: Add SVE decode skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 01/11/2018 08:12 PM, Richard Henderson wrote:
> On 01/11/2018 10:20 AM, Peter Maydell wrote:
>> On 18 December 2017 at 17:45, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
> 
> I didn't want to attempt to generalize this until we have two users.
> Particularly if we wind up with extra options to the script to change other
> behavior.

I might be exactly the second user. I think there is little sense having
two generator scripts (one for ARM, and one for RISCV). Unfortunately I
missed the original mail of Richard and can't find it anywhere in my
mailbox. What is the best way to leave some review comment's for
Richards patch containing scripts/decodetree.py, since I cannot inline
it in a mail?

Cheers,
Bastian

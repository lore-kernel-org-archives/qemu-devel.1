Received: from eggs.gnu.org ([2001:4830:134:3::10]:38412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gG51V-0003Pe-Kv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gG51V-0006H6-2E
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:31:45 -0400
Date: Fri, 26 Oct 2018 12:31:24 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181026163124.GA11593@flamenco>
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-36-cota@braap.org>
	<87d0rw25fa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0rw25fa.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC v4 36/71] arm: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Oct 26, 2018 at 14:39:21 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> 
> This will need to catch-up in the next re-base as there is a merge conflict.

Yep, this series is so long that I decided to keep the same
baseline as in v3, so that I could just git diff the two
branches to track the delta.

I'll rebase on master in the next iteration.

Thanks,

		Emilio

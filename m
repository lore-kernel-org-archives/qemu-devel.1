Received: from eggs.gnu.org ([2001:4830:134:3::10]:47117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eGnYo-0006Nm-85
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eGnYf-0000vb-3n
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:00:34 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1511184421-23535-1-git-send-email-peter.maydell@linaro.org>
	<1511184421-23535-3-git-send-email-peter.maydell@linaro.org>
	<1aaf0a6f-c38b-d80d-b09a-1a54545c7660@twiddle.net>
	<CAFEAcA-RXwYtL7yjNjxdHmuBfHe61-mYNX6ytDJ4bETLyA3DHA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9c3820a5-f41d-f835-58bb-8dfb7233403b@twiddle.net>
Date: Mon, 20 Nov 2017 16:00:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RXwYtL7yjNjxdHmuBfHe61-mYNX6ytDJ4bETLyA3DHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/2] accel/tcg: Handle atomic
 accesses to notdirty memory correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stuart Monteith <stuart.monteith@linaro.org>

On 11/20/2017 03:47 PM, Peter Maydell wrote:
> (Having NDI be "mostly opaque apart from this one thing" is a
> little ugly, though.)

Yeah, well... nothing else sensible is coming to mind.


r~

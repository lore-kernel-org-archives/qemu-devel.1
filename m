Received: from eggs.gnu.org ([209.51.188.92]:57309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asmadeus@notk.org>) id 1ggftU-0004GE-5n
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asmadeus@notk.org>) id 1ggftT-0005b4-IF
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:09:24 -0500
Received: from nautica.notk.org ([91.121.71.147]:46701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <asmadeus@notk.org>) id 1ggftT-0005Wg-CJ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:09:23 -0500
Date: Tue, 8 Jan 2019 02:09:06 +0100
From: Dominique Martinet <asmadeus@codewreck.org>
Message-ID: <20190108010906.GA26465@nautica>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
	<20180719205545.16512-24-pasha.tatashin@oracle.com>
	<20181106054212.GA31768@nautica>
	<95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
	<20190102202032.GA1034@eldamar.local>
	<CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
	<20190103234339.GA17457@nautica>
	<CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
	<20190107234839.GA15269@nautica>
	<CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v15 23/26] sched: early boot clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Steven Sistare <steven.sistare@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org

Pavel Tatashin wrote on Mon, Jan 07, 2019:
> I did exactly the same sequence on Kaby Lake CPU and could not
> reproduce it. What is your host CPU?

skylake consumer laptop CPU: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz

I don't have any kaby lake around; I have access to older servers though...
-- 
Dominique

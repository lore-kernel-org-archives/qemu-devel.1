Received: from eggs.gnu.org ([2001:4830:134:3::10]:34528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIjm0-0001oD-JR
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIjlx-0000BQ-H2
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:49:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dIjlx-0000Ao-41
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:49:53 -0400
Date: Wed, 7 Jun 2017 18:49:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170607224949.GA25623@flamenco>
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<20170606171320.GA8115@flamenco> <877f0o3vbn.fsf@frigg.lan>
	<CAFEAcA8RBMtfS+5GP=cGeAdV+zgGRg5OPEAu_PY+_hEPcWaJqw@mail.gmail.com>
	<87zidjztrt.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zidjztrt.fsf@frigg.lan>
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: Peter Maydell <peter.maydell@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Wed, Jun 07, 2017 at 18:45:10 +0300, Lluís Vilanova wrote:
> If there is such renewed interest, I will carve a bit more time to bring the
> patches up to date and send the instrumentation ones for further discussion.

I'm very interested and have time to spend on it -- I'm working on a
simulator backend and would like to move ASAP from QSim[1] to qemu proper for
the front-end. BTW I left some comments/questions a few days ago on the
v7 patchset you sent in January (ouch!).

I can also help with testing or bringing patches up to date -- let me
know if you need any help.

Thanks,

		Emilio

[1] http://manifold.gatech.edu/projects/qsim-a-multicore-emulator/

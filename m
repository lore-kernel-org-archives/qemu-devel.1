Received: from eggs.gnu.org ([209.51.188.92]:58902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hGo3y-0006TU-L9
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hGo3w-0005wF-Bh
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:09:34 -0400
Received: from 5.itsy.de ([188.40.84.14]:47002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jo@durchholz.org>) id 1hGo3u-0005sj-OT
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:09:32 -0400
Received: from [192.168.178.32] (unknown [195.48.33.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 5.itsy.de (Postfix) with ESMTPSA id 242D9645AB
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:09:27 +0200 (CEST)
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
	<20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
	<00f0ada2-a68b-2264-ab72-f49fe7d654e7@durchholz.org>
	<20190417071012.fxedabu3makmoyuz@sirius.home.kraxel.org>
From: Joachim Durchholz <jo@durchholz.org>
Message-ID: <993002d4-28dd-00f0-e8c1-7b0d9ab2de12@durchholz.org>
Date: Wed, 17 Apr 2019 19:09:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190417071012.fxedabu3makmoyuz@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] curses.c: "We need a terminal output" ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sorry, I'm done having to argue against(!) a person who's stonewalling 
me by wilfully ignoring differences ("doesn't work perfectly" 
interpreted as "does not work at all"), discounting 
just-for-testing-purpose workarounds as if they were actual proposed 
solutions ("not a sane approach"), ignoring the use case (still 
insisting on terminal size mutability), and proposing a nonworking 
solution (-nographic does not give me any output, of course because it 
doesn't have a terminal to talk to).

Reminds me of discussions in the Maven group, there, anything that 
didn't fit their shiny predefined ideas was brushed off in a similar manner.
Choosing the same solution: Use a different workaround, chalk this up 
under the Passive-Aggressive Unhelpfulness Encountered column.

No hard feelings towards the community.

Have a nice day everyone.
Jo

P.S.: Frustrated. In two ways.
Latin "frustra" = "in vain".

P.P.S.: I will stick around a bit so I can answer to questions based on 
genuine interest, but I'll disconnect from the list after that.

P.P.P.S.: No hard feelings towards the community in general. In fact, 
thanks to those two who tried to help.

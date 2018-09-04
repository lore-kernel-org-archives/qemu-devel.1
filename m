Received: from eggs.gnu.org ([2001:4830:134:3::10]:60429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fxIw0-00041S-JY
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fxIvx-0004Gu-C3
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:32:28 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fxIvw-0004FR-SG
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:32:25 -0400
Date: Tue, 4 Sep 2018 17:32:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180904213220.GA1850@flamenco>
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-3-cota@braap.org>
	<20180904173734.GA18515@kermit-br-ibm-com>
	<20180904193538.GA30725@flamenco>
	<20180904205631.GB18515@kermit-br-ibm-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904205631.GB18515@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [PATCH 2/6] test-rcu-list: avoid torn accesses to
 n_reclaims and n_nodes_removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Tue, Sep 04, 2018 at 17:56:31 -0300, Murilo Opsfelder Araujo wrote:
> The explanations you provided made a lot of difference on understanding the why
> of your patch.  Thank you!

Glad that helped!

> Is it possible to enhance commit message and add the explanations?

If I end up submitting a v2 of this series due to code-related
changes, then I'll expand this patch's commit message.

Thanks,

		E.

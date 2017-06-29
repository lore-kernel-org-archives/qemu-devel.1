Received: from eggs.gnu.org ([2001:4830:134:3::10]:33459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQiYy-0005XB-R1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQiYx-0004qi-Tu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:09:28 -0400
Date: Thu, 29 Jun 2017 19:09:19 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170629230919.GC13979@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865292643.17063.14495945233139782748.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149865292643.17063.14495945233139782748.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v11 03/29] target: [tcg] Use a generic enum
 for DISAS_ values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, Alexander Graf <agraf@suse.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

On Wed, Jun 28, 2017 at 15:28:46 +0300, Lluís Vilanova wrote:
> Used later. An enum makes expected values explicit and bounds the value space of
> switches.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.

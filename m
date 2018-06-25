Received: from eggs.gnu.org ([2001:4830:134:3::10]:47073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fXMni-0002uV-OR
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fXMni-0002Ww-0s
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:24:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1fXMnh-0002Wi-SN
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:24:41 -0400
Date: Mon, 25 Jun 2018 10:24:39 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180625082439.GX24405@paraplu>
References: <20180615141609.20749-1-berrange@redhat.com>
	<20180615185805.GE7451@localhost.localdomain>
	<878t7cskaz.fsf@dusky.pond.sub.org>
	<20180625081859.GC18277@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625081859.GC18277@paraplu>
Subject: Re: [Qemu-devel] [PATCH] docs: add guidance on configuring CPU
 models for x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Jun 25, 2018 at 10:18:59AM +0200, Kashyap Chamarthy wrote:
> On Mon, Jun 18, 2018 at 08:03:32AM +0200, Markus Armbruster wrote:
> > Eduardo Habkost <ehabkost@redhat.com> writes:

[...]

> > Texinfo is simple.
> > 
> > If all else fails, ask for my help after soft freeze.
> 
> If someone already hasn't done it, I can help rewrite it.  (It'll let me
> try out 'Texinfo' in real and I have to deal with CPU modelling aspects
> elsewhere in the higher-level tools. :-))

Oops, Dan already did it in v2.  Please disregard the above.

(Sorry for the noise.)

-- 
/kashyap

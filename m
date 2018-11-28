Received: from eggs.gnu.org ([2001:4830:134:3::10]:45327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gS3zE-0003eq-Bx
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gS3zD-000112-4j
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:50:56 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gS3zC-0000AA-TK
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:50:55 -0500
Received: by mail-wr1-x431.google.com with SMTP id 96so27256287wrb.2
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 09:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20181128153526.10948-1-berrange@redhat.com>
	<165bc19e-8ed2-8979-aea7-0f6031fc6df2@redhat.com>
In-Reply-To: <165bc19e-8ed2-8979-aea7-0f6031fc6df2@redhat.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Wed, 28 Nov 2018 17:50:30 +0000
Message-ID: <CAHDbmO2Gt+5RWaJ8Ka3LpB8o4Anq+evtKDO1oc6+X8gF7LZsOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Document how to test the site
 with jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, raimue@macports.org, Yu Ning <yu.ning@intel.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Fine with me.

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

On Wed, 28 Nov 2018, 16:44 Paolo Bonzini <pbonzini@redhat.com wrote:

> On 28/11/18 16:35, Daniel P. Berrang=C3=A9 wrote:
> > Add a README file that tells people this is a jekyll based static
> > website, and shows people how to run jekyll for testing purposes.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >
> > NB, we should really mention a license in the README too, but I don't
> > see info about what license we consider qemu-web to be covered by...
>
>     47  Paolo Bonzini <pbonzini@redhat.com>
>     44  Michael Roth <mdroth@linux.vnet.ibm.com>
>     13  Thomas Huth <thuth@redhat.com>
>      3  Eric Blake <eblake@redhat.com>
>      2  Daniel P. Berrange <berrange@redhat.com>
>      2  Jeff Cody <jcody@redhat.com>
>      1  Alex Benn=C3=A9e <alex.bennee@linaro.org>
>      1  Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>      1  Fam Zheng <famz@redhat.com>
>      1  Rainer M=C3=BCller <raimue@macports.org>
>      1  Stefan Hajnoczi <stefanha@gmail.com>
>      1  Yu Ning <yu.ning@intel.com>
>
> Anybody (especially non-RH people) disagrees with dual-license CC-BY-SA
> 4.0 and GPLv2+?  (So that we can copy from blog posts to manuals)?
>
> Paolo
>

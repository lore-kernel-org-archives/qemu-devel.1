Received: from eggs.gnu.org ([2001:4830:134:3::10]:38088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGYMN-0004cs-DQ
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 17:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGYMM-0001dh-JT
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 17:46:43 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGYMM-0001dH-CN
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 17:46:42 -0500
Received: by mail-wm0-x232.google.com with SMTP id r68so15358149wmr.1
	for <qemu-devel@nongnu.org>; Sun, 19 Nov 2017 14:46:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171119224207.GA7484@localhost.localdomain>
References: <20171119224207.GA7484@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Nov 2017 22:46:20 +0000
Message-ID: <CAFEAcA-C3nwLrOcgFgN6t_UpzVr8xLJw0VE2Afe8abt2_U5k2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu.org vs qemu-project.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 19 November 2017 at 22:42, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Hi,
>
> I've noticed that README, MAINTAINERS .gitmodules, and other
> files in qemu.git are pointing to qemu-project.org, while the
> QEMU web site and other files in qemu.git are pointing to
> qemu.org.
>
> I assume that the situation mentioned in commit
> 8593898109 ("Use qemu-project.org domain name") has improved.
> Should we update the existing files to point to qemu.org, now?

Yeah, we decided that we should go with qemu.org as the
main name (so qemu-project.org urls redirect to it).
We should probably generally move to qemu.org in our
documentation, at least. I'm not sure if there are
any unfortunate side-effects to changing a .gitmodules
URL ?

thanks
-- PMM

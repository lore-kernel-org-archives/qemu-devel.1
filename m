Received: from eggs.gnu.org ([2001:4830:134:3::10]:35102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXUbI-0003uU-Ql
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXUbI-0000hw-4a
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:44:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fXUbH-0000ho-Vb
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:44:24 -0400
References: <20180625160658.7315-1-pbonzini@redhat.com>
	<CAFEAcA-8aTBLEm+ZmyffVzVdbBjqbJ4rbGg5kz7dUwNEBNz3Jg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ea291e9-6493-b492-e701-edd3291b7710@redhat.com>
Date: Mon, 25 Jun 2018 18:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8aTBLEm+ZmyffVzVdbBjqbJ4rbGg5kz7dUwNEBNz3Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] osdep: work around Coverity parsing errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 25/06/2018 18:23, Peter Maydell wrote:
> I think it would help to repeat the rationale in a comment here,
> to avoid the necessity to dig it out of the git log.

Good idea, I'll copy the commit message in there.

Paolo

> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

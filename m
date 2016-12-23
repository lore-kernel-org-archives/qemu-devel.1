Received: from eggs.gnu.org ([2001:4830:134:3::10]:52451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cKQdh-0008Nz-GK
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 09:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cKQde-0004wg-9C
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 09:16:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cKQde-0004wQ-4A
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 09:16:02 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6803686-9435-0276-0118-10961dc97e04@redhat.com>
Date: Fri, 23 Dec 2016 15:15:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Proposal for 2.9 release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

Considering that Easter is on April 16th, we'd probably want to have the
release before that date even in case of a slip.

On the other hand, the Christmas / New Year break here means that we'll
have to make the development time 1-2 week shorter in practice.

2016-02-21     2.9 soft freeze
2016-03-07     hard freeze / rc0
2016-03-28     rc3 (+3 weeks)
2016-04-04     rc4 or release
2016-04-11     release (if rc4)

One possibility is to make soft freeze happen a few days later.
Peter/Stefan, how did the experiment go with the new rules for soft
freeze?  Is it worth repeating it for 2.9 and would it make sense to
shorten soft freeze given the new rules?

Thanks,

Paolo

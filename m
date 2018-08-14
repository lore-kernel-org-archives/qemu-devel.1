Received: from eggs.gnu.org ([2001:4830:134:3::10]:35706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fpWKW-00081p-TB
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fpWKR-0004ZR-WD
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:13:36 -0400
Received: from smtp56.i.mail.ru ([217.69.128.36]:47796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fpWKR-0004Vq-Jc
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:13:31 -0400
References: <20180813102037.12097-1-jusual@mail.ru>
	<9aee6f27-6a6d-2703-f49d-78c6bd3f7bc3@redhat.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <807bfc5e-8e5e-412e-67fa-a0e735ba1494@mail.ru>
Date: Tue, 14 Aug 2018 13:13:24 +0300
MIME-Version: 1.0
In-Reply-To: <9aee6f27-6a6d-2703-f49d-78c6bd3f7bc3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 13.08.2018 15:02, Paolo Bonzini wrote:
> Thanks Julia, just a few cleanups to simplify the prototypes of some
> functions.

Thanks for the review, I'll do the refactoring.

Best regards, Julia Suvorova.

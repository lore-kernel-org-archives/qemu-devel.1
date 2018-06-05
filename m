Received: from eggs.gnu.org ([2001:4830:134:3::10]:48807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQDGt-0002tx-90
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQDGq-0001El-2Q
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:49:15 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQDGp-0001Eg-SA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:49:11 -0400
Received: by mail-qk0-x243.google.com with SMTP id q70-v6so1681914qke.1
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 07:49:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530184156.15634-1-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe720a76-5d39-e26a-79a8-9ffb6c6b7113@amsat.org>
Date: Tue, 5 Jun 2018 11:49:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180530184156.15634-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/5] Acceptance/functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <amador@pahim.org>

Hi Eduardo,

On 05/30/2018 03:41 PM, Cleber Rosa wrote:
> TL;DR
> =====
> 
> Another version, with a minimalist approach, of the acceptance tests
> infrastructure for QEMU, based on the Avocado Testing Framework.

What do you think of this series?

Are you OK to take it via your tree, or should it goes via Fam's "Build
and test automation"?

Thanks,

Phil.

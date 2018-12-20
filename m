Received: from eggs.gnu.org ([2001:4830:134:3::10]:35959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gZujy-0003Kf-Fc
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gZujv-0007qc-9I
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:35:38 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1gZuju-0007pp-Ri
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:35:35 -0500
Received: by mail-wr1-x444.google.com with SMTP id t6so957642wrr.12
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 01:35:34 -0800 (PST)
References: <20181217164847.24411-1-remy.noel@blade-group.com>
	<eca584ae-042b-39f7-ca23-c23573676675@redhat.com>
	<5e90fbad-578a-5f0a-7c6d-e06dae7ba8a3@blade-group.com>
	<a8813976-fe90-a77a-d75b-0201300ae6ab@redhat.com>
From: Remy NOEL <remy.noel@blade-group.com>
Message-ID: <00c49d20-8c19-e543-2630-a215da8b01fb@blade-group.com>
Date: Thu, 20 Dec 2018 10:35:53 +0100
MIME-Version: 1.0
In-Reply-To: <a8813976-fe90-a77a-d75b-0201300ae6ab@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v3] aio-posix: Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>

On 12/19/18 8:32 PM, Paolo Bonzini wrote:

> You found another bug then. :)
K. Will fix.

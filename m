Received: from eggs.gnu.org ([2001:4830:134:3::10]:49049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAdZo-0007WV-Kd
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAdZn-0005Bd-LM
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:35:52 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:34909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAdZn-0005At-Ek
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:35:51 -0400
Received: by mail-wm0-x234.google.com with SMTP id b84so136441046wmh.0
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 07:35:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170512155249.8853-1-quintela@redhat.com>
References: <20170512155249.8853-1-quintela@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 16 May 2017 15:35:49 +0100
Message-ID: <CAJSP0QXO=-srhAdVvvF5f9Q=OtU7qbRwEmfrAfRxp4DiJgxwqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, peterx@redhat.com

On Fri, May 12, 2017 at 4:52 PM, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This pull contains:
> - Fix regression with compression threads (mea culpa)
> - start of includes migration (creating of blocker.h header)
> - Use Error** correctly after several iterations
> - Rename of RAM_SAVE_FLAG_COMPRESS
> - Create block capabilities for shared and enable
>
> Please, apply.

I have reverted the pull request at Juan's request.

Stefan

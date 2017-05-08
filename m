Received: from eggs.gnu.org ([2001:4830:134:3::10]:44876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7e99-0000Gw-0H
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7e94-0003ZG-09
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:35:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d7e93-0003Z7-K9
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:35:53 -0400
Date: Mon, 8 May 2017 09:35:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170508083547.GB2446@work-vm>
References: <CAGKXQyc4ye4Haxmt+C2D_s8MVF=zt8uu0QfG0f5WwCG15kw7ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGKXQyc4ye4Haxmt+C2D_s8MVF=zt8uu0QfG0f5WwCG15kw7ZQ@mail.gmail.com>
Subject: Re: [Qemu-devel] MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org

* ali saeedi (ali.saeedi56@gmail.com) wrote:
> Hi
> what are 'blk' and 'shared' boolean variables in MigrationParams structure
> in migration.h?

Follow the code! They're the flags used in the migrate command when
doing block migration.

Dave

> thanks a lot
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

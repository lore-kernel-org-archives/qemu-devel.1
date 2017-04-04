Received: from eggs.gnu.org ([2001:4830:134:3::10]:55208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvLf8-0004FY-F8
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvLf3-0000Ml-ER
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cvLf3-0000K1-8z
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:26:05 -0400
Date: Tue, 4 Apr 2017 11:26:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170404102600.GE2147@work-vm>
References: <CAGKXQyfV_0CPKYwiBiUnVXtP4v0-U-T2QOzk1gnoinDHAHSMjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGKXQyfV_0CPKYwiBiUnVXtP4v0-U-T2QOzk1gnoinDHAHSMjA@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu_savevm_state_header()
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
> I am new in qemu vm live migration. what does 'qemu_savevm_state_header()'
> fuction do?

It stores the header that goes at the beginning of the migration stream.

Dave

> thanks
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

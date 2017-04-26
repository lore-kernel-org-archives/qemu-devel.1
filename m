Received: from eggs.gnu.org ([2001:4830:134:3::10]:60739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3HI6-0007zD-Pd
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3HI3-0008HW-MU
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:23:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3HI3-0008HE-Dc
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:23:07 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <28a928dd-eb0c-8f60-95ba-2233379b21e8@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	25 Apr 2017 22:43:34 -0300")
References: <20170425223739.6703-1-quintela@redhat.com>
	<20170425223739.6703-11-quintela@redhat.com>
	<28a928dd-eb0c-8f60-95ba-2233379b21e8@amsat.org>
Reply-To: quintela@redhat.com
Date: Wed, 26 Apr 2017 09:23:02 +0200
Message-ID: <871ssfmy3t.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/26] audio: Remove INT32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> Hi Juan, is there a benefit in not squashing the previous stdint commits?

Easier to commit/review/rebase.

I can do if you preffer.

Later, Juan.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsP6q-0001ZT-A5
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsP6n-0003LU-8H
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:02:52 -0400
References: <20170823152736.21814-1-lyan@suse.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <27ab4e98-1b7a-e944-cf2a-ef6dad426ea4@msgid.tls.msk.ru>
Date: Thu, 14 Sep 2017 11:02:47 +0300
MIME-Version: 1.0
In-Reply-To: <20170823152736.21814-1-lyan@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/display/xenfb.c: Add
 trace_xenfb_key_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Yan <lyan@suse.com>, sstabellini@kernel.org, anthony.perard@citrix.com
Cc: qemu-trivial@nongnu.org, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

23.08.2017 18:27, Liang Yan wrote:
> It may be better to add a trace event to monitor the last moment of
> a key event from QEMU to guest VM

The patch looks okay, hopefully it is also useful - I haven't dealt with
xen and with keys it sends to a guest :)

Applied to -trivial, thanks!

/mjt

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dE40M-0005tT-KU
	for qemu-devel@nongnu.org; Thu, 25 May 2017 21:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dE40L-0008JI-Rl
	for qemu-devel@nongnu.org; Thu, 25 May 2017 21:25:26 -0400
Date: Fri, 26 May 2017 09:25:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170526012515.GA19490@lemon.lan>
References: <20170525163225.29954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170525163225.29954-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/18] Block layer thread safety, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com

On Thu, 05/25 18:32, Paolo Bonzini wrote:
> Minimal changes to:
> - fix compilation (patch 10)
> - appease checkpatch (patch 17)
> - rename mutex field from "spin" to "lock" (patch 18)

Thanks, queued.

Fam

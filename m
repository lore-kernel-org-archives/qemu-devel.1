Received: from eggs.gnu.org ([2001:4830:134:3::10]:48521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIb8a-0006qQ-4X
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIb8Z-0002Cf-AI
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:41:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fIb8Z-0002CW-4p
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:41:11 -0400
Date: Tue, 15 May 2018 16:41:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180515164107.42ea4257@redhat.com>
In-Reply-To: <1525854869-13975-1-git-send-email-jingqi.liu@intel.com>
References: <1525854869-13975-1-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/7] hmat acpi: Build Memory Subsystem
 Address Range Structre(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Jingqi <jingqi.liu@intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On Wed,  9 May 2018 16:34:29 +0800
Liu Jingqi <jingqi.liu@intel.com> wrote:

series submission note

Could you use cover letter when sending multipatch series please?
It should describe whole series impact and provides anchor point for thread.
Look for 'git --cover-letter' in git's man page.

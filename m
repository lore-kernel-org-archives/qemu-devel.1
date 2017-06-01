Received: from eggs.gnu.org ([2001:4830:134:3::10]:49320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGSti-00035o-1p
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGSte-00031C-Uf
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:24:30 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496310843-28771-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 1 Jun 2017 11:54:03 +0200")
References: <1496310843-28771-1-git-send-email-thuth@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 01 Jun 2017 18:24:22 +0200
Message-ID: <87shjjekw9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/core: nmi.c can be compiled as
 common-obj nowadays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

Thomas Huth <thuth@redhat.com> wrote:
> The target-specific code in nmi.c has been removed with this commit:
>
> 	commit f7e981f29548fe4af7812f5920304fe607e5bf0d
> 	nmi: remove x86 specific nmi handling
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

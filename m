Received: from eggs.gnu.org ([2001:4830:134:3::10]:34131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dz6dI-0002DR-93
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dz6dH-0003OS-MD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:44:04 -0400
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:52293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dz6dH-0003OA-HJ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:44:03 -0400
Received: by mail-io0-x229.google.com with SMTP id i197so5707397ioe.9
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 12:44:03 -0700 (PDT)
Date: Mon, 2 Oct 2017 15:43:59 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171002194359.GC22777@stefanha-x1.localdomain>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
Subject: Re: [Qemu-devel] [PATCH 00/43] Windbg supporting
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel@nongnu.org, sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org
List-ID: <qemu-devel.nongnu.org>

On Tue, Sep 26, 2017 at 02:04:06PM +0300, Mihail Abakumov wrote:
> We made the debugger module WinDbg (like GDB) for QEMU. This is the replacement of the remote stub in Windows kernel. Used for remote Windows kernel debugging without debugging mode.

How do the feature sets of the GDB remote protocol and WinDbg protocol
compare?  (I don't mean the debuggers themselves, but just the
protocols.)

Stefan

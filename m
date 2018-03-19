Received: from eggs.gnu.org ([2001:4830:134:3::10]:38615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exypG-0005Sk-Lm
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exypF-0000Pj-Up
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:44:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36130 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exypF-0000NW-Pj
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:44:01 -0400
References: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53df9c19-ca3f-2f47-c586-d270440fb74a@redhat.com>
Date: Mon, 19 Mar 2018 12:43:43 -0500
MIME-Version: 1.0
In-Reply-To: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] gdbstub: send a terminaison packet instead
 of crashing gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

On 03/16/2018 11:23 AM, KONRAD Frederic wrote:

In the subject: s/terminaison/termination/

> Since the commit:
> commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268
> Author: Stefan Hajnoczi <stefanha@redhat.com>
> Date:   Wed Mar 7 14:42:05 2018 +0000
> 
>      vl: introduce vm_shutdown()
> 
> GDB crash when qemu exits (at least on sparc-softmmu):

s/crash/crashes/

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

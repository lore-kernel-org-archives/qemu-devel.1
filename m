Received: from eggs.gnu.org ([209.51.188.92]:38658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1hJvvC-0007av-Mr
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1hJvvB-0005ai-I3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:09:26 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:37196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1hJvvB-0005Wq-CK
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:09:25 -0400
From: Lin Ma <lma@suse.com>
Message-ID: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
Date: Fri, 26 Apr 2019 16:09:12 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] About pt-br keyboard layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

Hi all,

While I launch qemu with vnc + pt-br keyboard layout on my pc, If I type 
shift + 6 in iPXE shell or grub shell via my usual 105-key keyboard,
shift + 6 would be mapped to "(apostrophe), But IIUC the correct 
character should be ¨(diaeresis) in pt-br layout.

I'm wondering that is it the expected behavior? In other words, Does it 
make sense if I want to type multi-character characters(say Ç or ¨) 
without guest os's help?



About pt-br keyboard (ABNT2), please refer to:
http://www.cjdinfo.com.br/utilitario-tabela-caracteres
https://docs.microsoft.com/en-us/globalization/keyboards/kbdbr_2.html


Any feedback would be appreciated,
Lin
